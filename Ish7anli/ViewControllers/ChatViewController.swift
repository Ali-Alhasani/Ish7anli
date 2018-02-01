//
//  ChatViewController.swift
//  new Puke
//
//  Created by Ali Al-Hassany on 11/4/17.
//  Copyright © 2017 Ali Al-Hassany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import JSQMessagesViewController
import Photos

enum SenderType: String {
    case U,C
}

class ChatViewController: JSQMessagesViewController {

    var targetId: String = ""
    var name: String = ""
   // var senderId:String = ""
    var senderType: SenderType? = nil
    
    var db:Firestore? = nil
    var ref: CollectionReference? = nil

    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()


    var collectionName: String = ""



    var messages = [JSQMessage]()


    private var photoMessageMap = [String: JSQPhotoMediaItem]()
    private var updatedMessageRefHandle: DatabaseHandle?
    var secondsFromGMT: Int { return 0 }
    var isNoDataRemaingInFireBase = false

            //title = channel?.name

//    deinit {
//        if let refHandle = newMessageRefHandle {
//            messageRef.removeObserver(withHandle: refHandle)
//        }
//
//        if let refHandle = updatedMessageRefHandle {
//            messageRef.removeObserver(withHandle: refHandle)
//        }
//    }
    
    
    func getCollectionName(){
        
        if senderType == .C{
            if (senderId < targetId ){
            collectionName = senderId+"C::" + targetId+"U"
            }else{
                  collectionName = targetId+"U::" + targetId+"C"
            }
        }else if (senderType == .U){
            if (senderId < targetId ){
                collectionName = senderId+"U::" + targetId+"C"
            }else{
                collectionName = targetId+"C::" + targetId+"U"
            }
        }
        
//        if senderId < targetId {
//            collectionName = senderId+"\(senderType?.rawValue)::"+targetId+"
//        }else{
//            collectionName = targetId+"::"+senderId
//        }
        db = Firestore.firestore()
        ref = db?.collection(collectionName)
        fetchMessages()
        observeMessages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.senderId = ""

        
        
     //senderId =
     senderDisplayName = ""
     //   clientName =
        
        getCollectionName()
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero

       // observeMessages()
       // db.collection("Fucking my method")
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      

    }
    // MARK: Collection view data source (and related) methods

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView?, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString? {
        let message = messages[indexPath.item]
        switch message.senderId {
        case senderId:
            return nil
        default:
            guard let senderDisplayName = message.senderDisplayName else {
                assertionFailure()
                return nil
            }
            return NSAttributedString(string: senderDisplayName)
        }
    }



    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }

    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }



      // No avatars
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }




    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]

        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }


    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {

//        let itemRef = messageRef.childByAutoId() // 1
//        let messageItem = [ // 2
//            "senderId": senderId!,
//            "senderName": senderDisplayName!,
//            "text": text!,
//            ]
//
//        itemRef.setValue(messageItem) // 3
//
//        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        addNewMessage(senderId: senderId, displayName: senderDisplayName, type: "TEXT", text: text, downloadUrl: nil)
        //finishSendingMessage()
        finishSendingMessage() // 5
    }

    func fetchMessages(){
        if self.isNoDataRemaingInFireBase{return}
        guard let chatRef = ref else {return}
        var query = chatRef.order(by: "creationDate", descending: true).limit(to: 6)
        var value: Double? = nil
        if messages.count > 0 {
            value = ((messages.first?.date.timeIntervalSince1970)! - Double(secondsFromGMT))*1000
            query = query.start(after: [value!])
        }else{
           // ActivityIndicatorManager.start()
        }
        query.getDocuments(completion: { (snapshot, error) in
            if error != nil{
                print("error in fetching documents:",error?.localizedDescription ?? "error")
            }else{
                guard let documents = snapshot?.documents else {return}
                documents.forEach({ (document) in
                    let dict = document.data()
                    print(dict)
                    guard let message = self.extractMessageData(dictionary: dict) else {
                       // ActivityIndicatorManager.stop(completionIndicator: .success, title: "Error")
                        return}
                    self.messages.insert(message, at: 0)
                })
                if documents.count == 0{
                    self.isNoDataRemaingInFireBase = true
                }
                if value != nil{
                    let indexPath = IndexPath(item: self.messages.count - (self.messages.count - documents.count - 1), section: 0)
                    self.collectionView.reloadData()
                    self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredVertically, animated: false)
                }else{
                    self.scrollCollectionViewDown()
                }
                //ActivityIndicatorManager.stop(completionIndicator: .success, title: "Success")
            }
        })
    }
    

    private func observeMessages() {
        guard let refCollection = ref else {return}
        let dateInSecs = (Date().timeIntervalSince1970 - Double(secondsFromGMT)) * 1000
        refCollection.whereField("creationDate", isGreaterThan: dateInSecs).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach({ (docDif) in
                let dict = docDif.document.data()
                if  docDif.type == .added{
                    guard let message = self.extractMessageData(dictionary: dict) else {return}
                    self.messages.append(message)
                    //self.scrollCollectionViewDown()
                }
            })
        }
    }
    
    func extractMessageData(dictionary: [String: Any]) -> JSQMessage? {
        let type = dictionary["type"] as! String
        let senderId = dictionary["senderId"] as! String
        let displayName = dictionary["displayName"] as! String
        var secondForm1970 = dictionary["creationDate"] as! Double
        // 3 + 2 = 5
        let temp = (secondForm1970/1000) + Double(secondsFromGMT)
        let creationDate = Date(timeIntervalSince1970: (temp))
        
        if type == "TEXT"{
            guard let text = dictionary["text"] else {return nil}
            return JSQMessage(senderId: senderId, senderDisplayName: displayName, date: creationDate, text: text as! String)
        }
        
        return nil
    }
    
    func addNewMessage(senderId: String, displayName: String,type: String ,text: String?,downloadUrl: String?)
    {
        guard let refCollection = ref else {return}
        //5 - (-2)
        let dateInSecs = (Date().timeIntervalSince1970 - Double(secondsFromGMT)) * 1000
        if type == "TEXT" {
            guard let text = text else  {return}
            let dict = ["senderId": senderId, "displayName": displayName, "creationDate": dateInSecs ,"type": type, "text": text ] as [String : Any]
            refCollection.addDocument(data: dict)
           // AddMessageNotification(withText: text, type: "TEXT")
        }
    }
    
    func scrollCollectionViewDown(){
        if messages.count > 0{
            collectionView.reloadData()
            let indexPath = IndexPath(item: messages.count-1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
        }
    }
        
        
//        guard let refCollection = ref else {return}
//
//        messageRef = channelRef!.child("messages")
//        // 1.
//        let messageQuery = messageRef.queryLimited(toLast:25)
//
//        // 2. We can use the observe method to listen for new
//        // messages being written to the Firebase DB
//        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
//            // 3
//            let messageData = snapshot.value as! Dictionary<String, String>
//
//            if let id = messageData["senderId"] as String!, let name = messageData["displayName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
//                // 4
//                self.addMessage(withId: id, name: name, text: text)
//
//                // 5
//                self.finishReceivingMessage()
//
//            }else if let id = messageData["senderId"] as String!,
//                let photoURL = messageData["photoURL"] as String! { // 1
//                // 2
//                if let mediaItem = JSQPhotoMediaItem(maskAsOutgoing: id == self.senderId) {
//                    // 3
//                    self.addPhotoMessage(withId: id, key: snapshot.key, mediaItem: mediaItem)
//                    // 4
//                    if photoURL.hasPrefix("gs://") {
//                        self.fetchImageDataAtURL(photoURL, forMediaItem: mediaItem, clearsPhotoMessageMapOnSuccessForKey: nil)
//                    }
//                }
//            } else {
//                print("Error! Could not decode message data")
//            }
//
//        })
//        updatedMessageRefHandle = messageRef.observe(.childChanged, with: { (snapshot) in
//            let key = snapshot.key
//            let messageData = snapshot.value as! Dictionary<String, String> // 1
//
//            if let photoURL = messageData["photoURL"] as String! { // 2
//                // The photo has been updated.
//                if let mediaItem = self.photoMessageMap[key] { // 3
//                    self.fetchImageDataAtURL(photoURL, forMediaItem: mediaItem, clearsPhotoMessageMapOnSuccessForKey: key) // 4
//                }
//            }
//        })
   // }


  

  

   






   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}




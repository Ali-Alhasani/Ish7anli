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
    case U,C,CC
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
    
    
    var isFirstRunForObserver = true
    var isFirstTimeToLoadData = true
    var messages = [JSQMessage]()
    
    var ok,error,alartTitle,loadingtitle,message:String?
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
            
            if (senderId > targetId ){
                collectionName = senderId+"C::" + targetId+"U"
            }else{
                collectionName = targetId+"U::" + senderId+"C"
            }
        }else if (senderType == .U){
            if (senderId > targetId ){
                collectionName = senderId+"U::" + targetId+"C"
            }else{
                collectionName = targetId+"C::" + senderId+"U"
            }
        }else if (senderType == .CC){
            if (senderId > targetId ){
                collectionName = senderId+"C::" + targetId+"C"
            }else{
                collectionName = targetId+"C::" + senderId+"C"
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
        if MOLHLanguage.isRTL() {
            self.title = "المحادثات"
        }else{
            self.title = "Chat"
        }
        self.inputToolbar.contentView.leftBarButtonItem = nil;
        
        senderId = SessionManager.shared.userId
        senderDisplayName = SessionManager.shared.displayName
        //   clientName =
        
        getCollectionName()
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        self.collectionView.collectionViewLayout.springinessEnabled = false
        self.navigationController?.toolbar.isTranslucent = false
        self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = UIColor.white
//        if #available(iOS 11.0, *) {
//        // collectionView.contentInsetAdjustmentBehavior = .never
//       collectionView.contentInset = UIEdgeInsets.zero
////
//     collectionView.scrollIndicatorInsets = UIEdgeInsets.zero;
////
//      collectionView.contentOffset = CGPoint(x: 0.0, y: 0.0);
// } else {
//       automaticallyAdjustsScrollViewInsets = false
//     }
       // self..contentInsetAdjustmentBehavior = .always
           //self.collectionView.contentInsetAdjustmentBehavior = .never
        //  observeMessages()
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
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        addNewMessage(senderId: senderId, displayName: senderDisplayName, type: "TEXT", text: text, downloadUrl: nil)
        //finishSendingMessage()
        finishSendingMessage() // 5
    }
    
    func fetchMessages(){
        if self.isNoDataRemaingInFireBase{return}
        guard let chatRef = ref else {return}
        var query = chatRef.order(by: "creationDate", descending: true).limit(to: 9)
        var value: Double? = nil
        if messages.count > 0 {
            value = ((messages.first?.date.timeIntervalSince1970)! - Double(secondsFromGMT))*1000
            query = query.start(after: [value!])
        }else{
            let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            if MOLHLanguage.isRTL() {
                self.loadingtitle = "جارى الإرسال"
                self.message = "الرجاء الانتظار"
            }else{
                self.loadingtitle = "Sending"
                self.message = "Please Wait"
            }
            spiningActivity.label.text = loadingtitle
            spiningActivity.detailsLabel.text = message
            
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
                        MBProgressHUD.hide(for: self.view, animated: true)
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
                MBProgressHUD.hide(for: self.view, animated: true)
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
                    self.scrollCollectionViewDown()
                }
            })
        }
    }
    
    func extractMessageData(dictionary: [String: Any]) -> JSQMessage? {
        let type = dictionary["type"] as! String
        let senderId = dictionary["senderId"] as! String
        let displayName = dictionary["displayName"] as! String
        let secondForm1970 = dictionary["creationDate"] as! Double
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
            AddMessageNotification(withText: text, type: "TEXT")
        }
    }
    func AddMessageNotification(withText text: String?, type: String){
        var tempDic:Dictionary<String,Any> = [:]
        if type == "VOICE"{
            tempDic["body"] = "New voice record added from "+senderId!
        }else if type == "IMAGE"{
            tempDic["body"] = "New image added from "+senderId!
        }else if type == "TEXT"{
            tempDic["body"] = text!
        }
        tempDic["message"] = "New Message added from "+senderDisplayName!
        tempDic["recever_id"] = targetId
        
        // tempDic["Type"] = "2"
        var data:Dictionary<String, Any> = [:]
        data = tempDic
        
        DataClient.shared.requestAddNotification(data: data, success: {
            
        }, failuer: { (error) in
            
        })
    }
    func scrollCollectionViewDown(){
        if messages.count > 0{
            collectionView.reloadData()
            let indexPath = IndexPath(item: messages.count-1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      if scrollView.contentInset.top == 0{
            self.isFirstTimeToLoadData = false
            
            fetchMessages()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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




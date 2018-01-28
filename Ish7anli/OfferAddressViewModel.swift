//
//  OfferAddressViewModel.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/22/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
enum OfferAddressViewModelItemType: String {
    case senderAddress = "senderAddress"
    case addSenderAddress = "addSenderAddress"
    case receiverAddress = "receiverAddress"
    case addReceiverAddress = "addReceiverAddress"
    case weight = "weight"
    case receiverInformation = "receiverInformation"
    case addOrderButton = "addOrderButton"
}

protocol OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType { get }
    var sectionTitle: String { get }
    var cellItems: [CellItem] { get}
}



var selectedSender: Int = 0
var selectedReceiver: Int = 0
var selectedWeghit2: Int = 0

var textPalceHolder = ["Name", "Mobile"]

protocol OfferAddressViewModelDelegate: class {
    func apply(changes: SectionChanges)
    func move()
    func move2(_ senderAddress:String , _ receiveAddress:String , weghitIndex:Int )
    func apply2()
}

class OfferAddressViewModel: NSObject {
    fileprivate var items = [OfferAddressViewModelItem]()
    
    weak var delegate: OfferAddressViewModelDelegate?
    
    private func flatten(items: [OfferAddressViewModelItem]) -> [ReloadableSection<CellItem>] {
        let reloadableItems = items
            .enumerated()
            .map { ReloadableSection(key: $0.element.type.rawValue, value: $0.element.cellItems
                .enumerated()
                .map { ReloadableCell(key: $0.element.id, value: $0.element, index: $0.offset)  }, index: $0.offset) }
        return reloadableItems
    }
    
    private func setup(newItems: [OfferAddressViewModelItem]) {
        let oldData = flatten(items: items)
        let newData = flatten(items: newItems)
        let sectionChanges = DiffCalculator.calculate(oldItems: oldData, newItems: newData)
        
        items = newItems
        delegate?.apply(changes: sectionChanges)
    }
    
    func addListener() {
        DataClient.shared.getProfile(success: { profile in
            self.parseData(profile: profile)
        }) { (_ error) in
            print(error)
        }
        
    }
    private func parseData(profile: Profile) {
        var newItems = [OfferAddressViewModelItem]()
        let address = profile.address
        let senderAddressItem = OfferAddressViewModeSenderAddressItem(address: address)
        newItems.append(senderAddressItem)
        
        
        let addSenderAddressItem = OfferAddressViewModeAddSenderAddress()
        newItems.append(addSenderAddressItem)
        
        let receiveAddressItem = OfferAddressViewModeReceiverAddressItem(address: address)
        newItems.append(receiveAddressItem)
        
        
        let addReceiveAddressItem = OfferAddressViewModeAddReceiveAddress()
        newItems.append(addReceiveAddressItem)
        
     
        
        let receiverInformationItem = OfferAddressViewModeReceiverInformation(text : textPalceHolder)
        newItems.append(receiverInformationItem)
        
        
        let addAddressWeghitItem = OfferAddressModeWeghitAddress(weghit : Weghit)
        newItems.append(addAddressWeghitItem)
        
        let addOrderButton = OfferAddressViewModeAddOrderButton()
        newItems.append(addOrderButton)
        
        setup(newItems: newItems)
        
    }
}

extension OfferAddressViewModel: UITableViewDataSource,AddAddressTableViewCellDelegate,ListTableViewCellDelegate,SubmitButtonTableViewCellDelegate{
    
    func didPressButtonSubmit(sender: UIButton) {
        var senderAddress:String?
        var receiverAddress:String?
        
        if let item = items[0] as? OfferAddressViewModeSenderAddressItem {
            senderAddress = item.address[selectedSender].id
        }
      
        if let item = items[2] as? OfferAddressViewModeReceiverAddressItem {
            receiverAddress = item.address[selectedReceiver].id
        }
        
//        if let item = items[4] as? OfferAddressViewModeReceiverInformation {
//           
//        }

        delegate?.move2(senderAddress!, receiverAddress!, weghitIndex: selectedWeghit2 + 1)


        
    }
    
    func didPressRadioButton(sender: UIButton, type: CellType) {
        switch type {
        case .address :
            selectedSender = sender.tag
            delegate?.apply2()
            
        case .item1:
            selectedType = sender.tag
            delegate?.apply2()
            
        case .item2:
            selectedWeghit = sender.tag
            delegate?.apply2()
        case .addressRecevier:
            selectedReceiver = sender.tag
            delegate?.apply2()
        }
    }
    
    func didPressRadioButton(sender: UIButton) {
        selected = sender.tag
        delegate?.apply2()
    }
    
    func didPressButton(sender: UIButton) {
        delegate?.move()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .senderAddress:
            if let item = item as? OfferAddressViewModeSenderAddressItem, let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.address[indexPath.row]
                cell.item = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selectedSender {
                    cell.button.isSelected = true
                }else {
                    cell.button.isSelected = false
                }
                
                
                return cell
            }
            
        case .addSenderAddress:
            if  let cell = tableView.dequeueReusableCell(withIdentifier: AddAddressTableViewCell.identifier, for: indexPath) as? AddAddressTableViewCell {
                cell.cellDelegate = self
                return cell
            }
            
        case .receiverAddress:
            if let item = item as? OfferAddressViewModeReceiverAddressItem, let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.address[indexPath.row]
                cell.itemReceiver = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selectedReceiver {
                    cell.button.isSelected = true
                }else {
                    cell.button.isSelected = false
                }
                
                
                return cell
            }
            
        case .addReceiverAddress:
            if  let cell = tableView.dequeueReusableCell(withIdentifier: AddAddressTableViewCell.identifier, for: indexPath) as? AddAddressTableViewCell {
                cell.cellDelegate = self
                return cell
            }
            
        case .receiverInformation:
        
            if let item = item as? OfferAddressViewModeReceiverInformation ,let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.identifier, for: indexPath) as? TextViewTableViewCell {
                let address = item.text[indexPath.row]
                cell.item = address
                //cell.textView.text = 
                //cell.cellDelegate = self
                //cell.button.tag = indexPath.row
              
                return cell
            }
        case .addOrderButton:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SubmitButtonTableViewCell.identifier, for: indexPath) as? SubmitButtonTableViewCell {
                cell.item = "Order"
                cell.cellDelegate = self
                return cell
            }
            
        case .weight:
            if let item = item as? OfferAddressModeWeghitAddress ,let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.weghit[indexPath.row]
                cell.item2 = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selectedWeghit2 {
                    cell.button.isSelected = true
                }else {
                    cell.button.isSelected = false
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}

extension OfferAddressViewModel:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.backgroundView?.backgroundColor = UIColor(named: "background")
            //headerTitle.textLabel?.backgroundColor = UIColor.clear
            headerTitle.textLabel?.textColor = UIColor(named: "niceBlue")
        }
    }
}
class OfferAddressViewModeSenderAddressItem: OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType {
        return .senderAddress
    }
    
    var sectionTitle: String {
        return "Sender Address"
    }
    var cellItems: [CellItem] {
        return address
            .map { CellItem(value: $0, id: $0.id!) }
    }
    //
    var address: [Address]
    
    init(address: [Address]) {
        self.address = address
    }
}
class OfferAddressViewModeAddSenderAddress: OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType {
        return .addSenderAddress
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}

class OfferAddressViewModeReceiverAddressItem: OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType {
        return .receiverAddress
    }
    
    var sectionTitle: String {
        return "Receiver Address"
    }
    var cellItems: [CellItem] {
        return address
            .map { CellItem(value: $0, id: $0.id!) }
    }
    //
    var address: [Address]
    
    init(address: [Address]) {
        self.address = address
    }
}

class OfferAddressViewModeAddReceiveAddress: OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType {
        return .addReceiverAddress
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}



class OfferAddressViewModeAddOrderButton: OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType {
        return .addOrderButton
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}

class OfferAddressModeWeghitAddress: OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType {
        return .weight
    }
    
    var sectionTitle: String {
        return "Weghit"
        
    }
    
    var cellItems: [CellItem] {
        return weghit
            .map { CellItem(value: $0, id: $0) }
    }
    
    var weghit: [String]
    
    init(weghit: [String]) {
        self.weghit = weghit
    }
}



class OfferAddressViewModeReceiverInformation: OfferAddressViewModelItem {
    var type: OfferAddressViewModelItemType {
        return .receiverInformation
    }
    
    var sectionTitle: String {
        return "Receiver Information"
        
    }
    
    var cellItems: [CellItem] {
        return textPalceHolder
            .map { CellItem(value: $0, id: $0) }
    }
    
    var text: [String]
    
    init(text: [String]) {
        self.text = text
    }
}





//
//  AddressViewModel22.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/25/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

enum AddressViewModel2ItemType: String {
    case address = "address"
    case addAddress = "addAddress"
    case receiverInformation = "receiverInformation"
    case addOrderButton = "addOrderButton"
}

protocol AddressViewModel2Item {
    var type: AddressViewModel2ItemType { get }
    var sectionTitle: String { get }
    var cellItems: [CellItem] { get}
}


var textPalceHolder2 = ["Name", "Mobile"]
var selectedAddress: Int = 0
var informationIndexPath2 = [Int]()


protocol AddressViewModel2Delegate: class {
    func apply(changes: SectionChanges)
    func move()
    func move2(_ receiverAddress:Int,information:[Int])

    func apply2()
}
class AddressViewModel2: NSObject {
    fileprivate var items = [AddressViewModel2Item]()
    
    weak var delegate: AddressViewModel2Delegate?
    
    private func flatten(items: [AddressViewModel2Item]) -> [ReloadableSection<CellItem>] {
        let reloadableItems = items
            .enumerated()
            .map { ReloadableSection(key: $0.element.type.rawValue, value: $0.element.cellItems
                .enumerated()
                .map { ReloadableCell(key: $0.element.id, value: $0.element, index: $0.offset)  }, index: $0.offset) }
        return reloadableItems
    }
    
    private func setup(newItems: [AddressViewModel2Item]) {
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
        var newItems = [AddressViewModel2Item]()
        let address = profile.address
        let addressItem = AddressViewMode2AddressItem(address: address)
        newItems.append(addressItem)
        
        if MOLHLanguage.isRTL() {
            textPalceHolder2 = ["الاسم","رقم الجوال"]
        }
        let addAddressItem = AddressViewMode2AddAddress()
        newItems.append(addAddressItem)
        
        let receiverInformationItem = OfferAddressViewMode2ReceiverInformation(text: textPalceHolder2)
        newItems.append(receiverInformationItem)
        
        let addOrderButton = AddressViewMode2AddOrderButton()
        newItems.append(addOrderButton)
        
        setup(newItems: newItems)
        
    }
}
extension AddressViewModel2: UITableViewDataSource,AddAddressTableViewCellDelegate,ListTableViewCellDelegate,SubmitButtonTableViewCellDelegate {
    func didPressButtonSubmit(sender: UIButton) {
     //delegate?.move2()
        
        
        var senderAddress:Int?
        
        if let item = items[0] as? AddressViewMode2AddressItem {
            senderAddress = item.address[selectedSender].id
        }
        
        //        if let item = items[4] as? OfferAddressViewModeReceiverInformation {
        ////            let cell = tableView.cellForRow(at:index) as! TextViewTableViewCell
        //
        //        }
        
        delegate?.move2(senderAddress!, information: informationIndexPath2)
        

    }
    
    func didPressRadioButton(sender: UIButton, type: CellType) {
        switch type {
        case .address :
            selectedAddress = sender.tag
            delegate?.apply2()
            
        case .item1:
            delegate?.apply2()
            
        case .weghit:
        delegate?.apply2()

        case .addressRecevier:
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
        case .address:
            if let item = item as? AddressViewMode2AddressItem, let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.address[indexPath.row]
                cell.item = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selectedAddress {
                    cell.button.isSelected = true
                }else {
                    cell.button.isSelected = false
                }
                
                
                return cell
            }
            
        case .addAddress:
            if  let cell = tableView.dequeueReusableCell(withIdentifier: AddAddressTableViewCell.identifier, for: indexPath) as? AddAddressTableViewCell {
                cell.cellDelegate = self
                return cell
            }
            
        case .receiverInformation:
            
            if let item = item as? OfferAddressViewMode2ReceiverInformation ,let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.identifier, for: indexPath) as? TextViewTableViewCell {
                let address = item.text[indexPath.row]
                informationIndexPath2.append(indexPath.row)
                cell.item = address
                //cell.textView.text =
                //cell.cellDelegate = self
                //cell.button.tag = indexPath.row
                
                return cell
            }
        case .addOrderButton:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SubmitButtonTableViewCell.identifier, for: indexPath) as? SubmitButtonTableViewCell {
                if MOLHLanguage.isRTL() {
                   cell.item = "استمرار"
                    
                }else{
                    cell.item = "Continue"
                }
                cell.cellDelegate = self
                return cell
            }
            
            
        }
        return UITableViewCell()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}

extension AddressViewModel2:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        print("Mother Fucker")
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.backgroundView?.backgroundColor = UIColor(named: "background")
            //headerTitle.textLabel?.backgroundColor = UIColor.clear
            headerTitle.textLabel?.textColor = UIColor(named: "niceBlue")
        }
    }
}
class AddressViewMode2AddressItem: AddressViewModel2Item {
    var type: AddressViewModel2ItemType {
        return .address
    }
    
    var sectionTitle: String {
        if MOLHLanguage.isRTL() {
            return "عنوان المستلم"
            
        }
        return "Receiver Address"
    }
    var cellItems: [CellItem] {
        return address
            .map { CellItem(value: $0, id: String($0.id!)) }
    }
    //
    var address: [Address]
    
    init(address: [Address]) {
        self.address = address
    }
}


class AddressViewMode2AddAddress: AddressViewModel2Item {
    var type: AddressViewModel2ItemType {
        return .addAddress
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}

class OfferAddressViewMode2ReceiverInformation: AddressViewModel2Item {
    var type: AddressViewModel2ItemType {
        return .receiverInformation
    }
    
    var sectionTitle: String {
        if MOLHLanguage.isRTL() {
            return "بيانات المستلم"
            
        }
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


class AddressViewMode2AddOrderButton: AddressViewModel2Item {
    var type: AddressViewModel2ItemType {
        return .addOrderButton
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}



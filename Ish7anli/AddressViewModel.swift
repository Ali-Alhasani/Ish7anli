//
//  AddressViewModel.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/19/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

enum AddressViewModelItemType: String {
    case address = "address"
    case addAddress = "addAddress"
    case type = "type"
    case weghit = "weghit"
    case addOrderButton = "addOrderButton"
}

protocol AddressViewModelItem {
    var type: AddressViewModelItemType { get }
    var sectionTitle: String { get }
    var cellItems: [CellItem] { get}
}

let Type = ["From the door to the door","From Caption Address"]
let Weghit = ["Light","Heavy"]
var addressbuttons = [RadioButton]()
var selected: Int = 0
var selectedType: Int = 0
var selectedWeghit: Int = 0

protocol AddressViewModelDelegate: class {
    func apply(changes: SectionChanges)
    func move()
    func apply2()
}
class AddressViewModel: NSObject {
    fileprivate var items = [AddressViewModelItem]()
    
    weak var delegate: AddressViewModelDelegate?
    
    private func flatten(items: [AddressViewModelItem]) -> [ReloadableSection<CellItem>] {
        let reloadableItems = items
            .enumerated()
            .map { ReloadableSection(key: $0.element.type.rawValue, value: $0.element.cellItems
                .enumerated()
                .map { ReloadableCell(key: $0.element.id, value: $0.element, index: $0.offset)  }, index: $0.offset) }
        return reloadableItems
    }
    
    private func setup(newItems: [AddressViewModelItem]) {
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
        var newItems = [AddressViewModelItem]()
        let address = profile.address
        let addressItem = AddressViewModeAddressItem(address: address)
        newItems.append(addressItem)
        
        
        let addAddressItem = AddressViewModeAddAddress()
        newItems.append(addAddressItem)
        
        let addAddressTypeItem = AddressViewModeTypeAddress(type : Type)
        newItems.append(addAddressTypeItem)
        
        let addAddressWeghitItem = AddressViewModeWeghitAddress(weghit : Weghit)
        newItems.append(addAddressWeghitItem)
        
        let addOrderButton = AddressViewModeAddOrderButton()
        newItems.append(addOrderButton)
        
        setup(newItems: newItems)
        
    }
}
extension AddressViewModel: UITableViewDataSource,AddressSettingsTableViewCellDelegate,AddAddressTableViewCellDelegate,ListTableViewCellDelegate {
    func didPressRadioButton(sender: UIButton, type: CellType) {
        switch type {
        case .address :
            selected = sender.tag
            delegate?.apply2()
    
        case .item1:
            selectedType = sender.tag
            delegate?.apply2()
            
        case .item2:
            selectedWeghit = sender.tag
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
    
    func didPressDeleteButton(sender: UIButton) {
        addListener()
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
            if let item = item as? AddressViewModeAddressItem, let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.address[indexPath.row]
                cell.item = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selected {
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
   
        case .type:
            if let item = item as? AddressViewModeTypeAddress ,let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.type2[indexPath.row]
                cell.item1 = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selectedType {
                    cell.button.isSelected = true
                }else {
                    cell.button.isSelected = false
                }
                return cell
            }
        case .weghit:
            if let item = item as? AddressViewModeWeghitAddress ,let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.weghit[indexPath.row]
                cell.item2 = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selectedWeghit {
                    cell.button.isSelected = true
                }else {
                    cell.button.isSelected = false
                }
                return cell
            }
        case .addOrderButton:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SubmitButtonTableViewCell.identifier, for: indexPath) as? SubmitButtonTableViewCell {
                cell.item = "Continue"
                return cell
            }
            
        
        }
        return UITableViewCell()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}

extension AddressViewModel:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        print("Mother Fucker")
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.backgroundView?.backgroundColor = UIColor(named: "background")
            headerTitle.textLabel?.backgroundColor = UIColor.clear
            headerTitle.textLabel?.textColor = UIColor(named: "niceBlue")
        }
    }
}
class AddressViewModeAddressItem: AddressViewModelItem {
    var type: AddressViewModelItemType {
        return .address
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

class AddressViewModeAddressItem2: AddressViewModelItem {
    var type: AddressViewModelItemType {
        return .address
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

class AddressViewModeAddAddress: AddressViewModelItem {
    var type: AddressViewModelItemType {
        return .addAddress
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}

class AddressViewModeTypeAddress: AddressViewModelItem {
    var type: AddressViewModelItemType {
        return .type
    }
    
    var sectionTitle: String {
        return "Delivery Type"
        
    }
    
    var cellItems: [CellItem] {
        return type2
            .map { CellItem(value: $0, id: $0) }
    }
    var type2: [String]
    
    init(type: [String]) {
       self.type2 = type
    }
}
class AddressViewModeWeghitAddress: AddressViewModelItem {
    var type: AddressViewModelItemType {
        return .weghit
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
class AddressViewModeAddOrderButton: AddressViewModelItem {
    var type: AddressViewModelItemType {
        return .addOrderButton
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}


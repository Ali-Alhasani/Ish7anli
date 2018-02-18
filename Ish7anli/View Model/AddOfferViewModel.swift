//
//  AddOfferViewModel.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/11/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
enum AddOfferViewModelItemType: String {
    case address = "address"
    case addAddress = "addAddress"
}

protocol AddOfferViewModelItem {
    var type: AddOfferViewModelItemType { get }
    var sectionTitle: String { get }
    var cellItems: [CellItem] { get}
}

protocol AddOfferViewModelDelegate: class {
    func apply(changes: SectionChanges)
    func move()
    func apply2(senderId:Int)
    
}
var selectedOffer: Int?

class AddOfferViewModel: NSObject {
    fileprivate var items = [AddOfferViewModelItem]()
    
    weak var delegate: AddOfferViewModelDelegate?
    
    private func flatten(items: [AddOfferViewModelItem]) -> [ReloadableSection<CellItem>] {
        let reloadableItems = items
            .enumerated()
            .map { ReloadableSection(key: $0.element.type.rawValue, value: $0.element.cellItems
                .enumerated()
                .map { ReloadableCell(key: $0.element.id, value: $0.element, index: $0.offset)  }, index: $0.offset) }
        return reloadableItems
    }
    
    private func setup(newItems: [AddOfferViewModelItem]) {
        let oldData = flatten(items: items)
        let newData = flatten(items: newItems)
        let sectionChanges = DiffCalculator.calculate(oldItems: oldData, newItems: newData)
        
        items = newItems
        delegate?.apply(changes: sectionChanges)
    }
    
    func addListener() {
        DataClient.shared.getCaptainProfile(success: { profile in
            self.parseData(profile: profile)
            
        }) { (_ error) in
            print(error)
        }
        
    }

    private func parseData(profile: CaptainProfile) {
        var newItems = [AddOfferViewModelItem]()
        let address = profile.address
        let addressItem = AddOfferViewModeAddressItem(address: address)
        newItems.append(addressItem)
        
        
        let addAddressItem = AddOfferViewModeAddAddress()
        newItems.append(addAddressItem)
        
     
        
        setup(newItems: newItems)
        
    }
}

extension AddOfferViewModel:UITableViewDataSource,AddAddressTableViewCellDelegate,ListTableViewCellDelegate {
    
    func didPressButton(sender: UIButton) {
         delegate?.move()
    }
    
    func didPressRadioButton(sender: UIButton, type: CellType) {
         switch type {
            
         case .address:
            
            selectedOffer = sender.tag
              var senderAddress:Int?
            if let item = items[0] as? AddOfferViewModeAddressItem {
                
                senderAddress = item.address[selectedOffer!].id
            }
            delegate?.apply2(senderId: senderAddress!)
         case .item1:
          print("")
         case .weghit:
              print("")
         case .addressRecevier:
             print("")
        }
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
            if let item = item as? AddOfferViewModeAddressItem, let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let address = item.address[indexPath.row]
                cell.item = address
                cell.cellDelegate = self
                cell.button.tag = indexPath.row
                if indexPath.row == selectedOffer {
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
    }
          return UITableViewCell()
    }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return items[section].sectionTitle
        }
}
extension AddOfferViewModel:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        print("Mother Fucker")
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.backgroundView?.backgroundColor = UIColor(named: "background")
            //headerTitle.textLabel?.backgroundColor = UIColor.clear
            headerTitle.textLabel?.textColor = UIColor(named: "niceBlue")
        }
    }
}


class AddOfferViewModeAddressItem: AddOfferViewModelItem {
    
    var type: AddOfferViewModelItemType {
        return .address
    }
    
    var sectionTitle: String {
        if MOLHLanguage.isRTL() {
            return "عنوان المرسل"
        }
        return "Sender Address"
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

class AddOfferViewModeAddAddress: AddOfferViewModelItem {
    var type: AddOfferViewModelItemType {
        return .addAddress
    }
    
    var sectionTitle: String {
        return ""
        
    }
    
    var cellItems: [CellItem] {
        return [CellItem(value: sectionTitle, id: sectionTitle)]
    }
}




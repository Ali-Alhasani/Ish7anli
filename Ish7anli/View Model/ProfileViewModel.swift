//
//  AddressViewModel.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
import UIKit


enum ProfileViewModelItemType: String {
   case address = "address"
  case addAddress = "addAddress"
}

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType { get }
    var sectionTitle: String { get }
    var cellItems: [CellItem] { get}
}

struct CellItem: Equatable {
    var value: CustomStringConvertible
    var id: String
    
    static func ==(lhs: CellItem, rhs: CellItem) -> Bool {
        return lhs.id == rhs.id && lhs.value.description == rhs.value.description
    }
}

protocol ProfileViewModelDelegate: class {
    func apply(changes: SectionChanges)
    func move()
    func finishLoadData()
}
class ProfileViewModel: NSObject {
    fileprivate var items = [ProfileViewModelItem]()
    
    weak var delegate: ProfileViewModelDelegate?
    
    private func flatten(items: [ProfileViewModelItem]) -> [ReloadableSection<CellItem>] {
        let reloadableItems = items
            .enumerated()
            .map { ReloadableSection(key: $0.element.type.rawValue, value: $0.element.cellItems
                .enumerated()
                .map { ReloadableCell(key: $0.element.id, value: $0.element, index: $0.offset)  }, index: $0.offset) }
        return reloadableItems
    }
    
    private func setup(newItems: [ProfileViewModelItem]) {
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
    func addSlientData() {
        DataClient.shared.getProfile(success: { profile in
              self.delegate?.finishLoadData()
        }) { (_ error) in
            print(error)
        }
        
    }
    private func parseData(profile: Profile) {
        var newItems = [ProfileViewModelItem]()
        let address = profile.address
        let addressItem = ProfileViewModeAddressItem(address: address)
        newItems.append(addressItem)
      
        
        let addAddressItem = ProfileViewModeAddAddress()
        newItems.append(addAddressItem)
        
        setup(newItems: newItems)
        
    }
}
extension ProfileViewModel: UITableViewDataSource,AddressSettingsTableViewCellDelegate,AddAddressTableViewCellDelegate {
  
    
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
                if let item = item as? ProfileViewModeAddressItem, let cell = tableView.dequeueReusableCell(withIdentifier: AddressSettingsTableViewCell.identifier, for: indexPath) as? AddressSettingsTableViewCell {
                    let address = item.address[indexPath.row]
                    cell.cellDelegate = self
                    cell.item = address
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

    extension ProfileViewModel:UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
            print("Mother Fucker")
            if let headerTitle = view as? UITableViewHeaderFooterView {
                headerTitle.backgroundView?.backgroundColor = UIColor(named: "background")
                //headerTitle.textLabel?.backgroundColor = UIColor.clear
                headerTitle.textLabel?.textColor = UIColor(named: "niceBlue")
            }
        }
    }
    
    class ProfileViewModeAddressItem: ProfileViewModelItem {
        var type: ProfileViewModelItemType {
            return .address
        }
        
        var sectionTitle: String {
            if MOLHLanguage.isRTL() {
                return "عناويني"
            }
            return "MY Address"
        }
//
//        var rowCount: Int {
//            return address.count
//        }
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
    
    class ProfileViewModeAddAddress: ProfileViewModelItem {
        var type: ProfileViewModelItemType {
            return .addAddress
        }
        
        var sectionTitle: String {
            return ""
            
        }
   
            var cellItems: [CellItem] {
                return [CellItem(value: sectionTitle, id: sectionTitle)]
            }
        }

        
        
//        var rowCount: Int {
//            return 1
//        }
        
        
        


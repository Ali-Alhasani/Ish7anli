//
//  AddressSettingsTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol AddressSettingsTableViewCellDelegate : class {
    func didPressDeleteButton(sender: UIButton)
}

class AddressSettingsTableViewCell: UITableViewCell {
    weak var cellDelegate: AddressSettingsTableViewCellDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var item: Address? {
        didSet {
            detailsLabel.text = item!.details
            nameLabel?.text = item!.title
        }
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
       
        
        DataClient.shared.deleteAddress(id: (item?.id)!, success: {
            self.cellDelegate?.didPressDeleteButton(sender: sender as! UIButton)
            
        }) { (_ error) in
            print("looser")
        }
    }
    
    
}

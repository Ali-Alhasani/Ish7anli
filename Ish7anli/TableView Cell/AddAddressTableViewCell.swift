//
//  AddAddressTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol AddAddressTableViewCellDelegate : class {
    func didPressButton(sender: UIButton)
}
protocol AddAddressTableViewCellDelegate2 : class {
    func didPressButton2(sender: UIButton)
}

class AddAddressTableViewCell: UITableViewCell{
 weak var cellDelegate: AddAddressTableViewCellDelegate?
    weak var cellDelegate2: AddAddressTableViewCellDelegate2?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    @IBAction func addAddressAction(_ sender: Any) {
        cellDelegate?.didPressButton(sender: sender as! UIButton)
        cellDelegate2?.didPressButton2(sender: sender as! UIButton)

    }
    
}

//
//  ListTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

protocol ListTableViewCellDelegate : class {
    func didPressRadioButton(sender: UIButton, type: CellType)
}

class ListTableViewCell: UITableViewCell {
     weak var cellDelegate: ListTableViewCellDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var button: RadioButton!
    
    var celltype : CellType?
    
    var item: Address? {
        didSet {
            nameLabel?.text = item!.title
            celltype = CellType.address
        }
    }
    var itemReceiver: Address? {
        didSet {
            nameLabel?.text = itemReceiver!.title
            celltype = CellType.addressRecevier
        }
    }
    var item1: String? {
        didSet {
            nameLabel?.text = item1!
            celltype = CellType.item1
        }
    }
    var item2: String? {
        didSet {
            nameLabel?.text = item2!
            celltype = CellType.item2
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonAction(_ sender: Any) {
        cellDelegate?.didPressRadioButton(sender: sender as! UIButton, type: celltype! )

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

enum CellType{
    case address, item1, item2, addressRecevier
}


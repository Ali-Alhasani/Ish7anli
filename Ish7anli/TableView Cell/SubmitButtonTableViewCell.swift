//
//  SubmitButtonTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/22/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

protocol SubmitButtonTableViewCellDelegate : class {
    func didPressButtonSubmit(sender: UIButton)
}

class SubmitButtonTableViewCell: UITableViewCell {
  weak var cellDelegate: SubmitButtonTableViewCellDelegate?
    @IBOutlet weak var sumbitButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var item: String? {
        didSet {
            sumbitButton?.setTitle(item, for: UIControlState.normal)
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
    
    @IBAction func orderButton(_ sender: Any) {
        cellDelegate?.didPressButtonSubmit(sender: sender as! UIButton)
    }
    
}

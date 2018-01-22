//
//  TmpTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/10/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol MessageTableViewCellDelegate : class {
    func didPressCell(sender: UIButton)
}
class TmpTableViewCell: UITableViewCell {
    weak var cellDelegate: MessageTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }


}

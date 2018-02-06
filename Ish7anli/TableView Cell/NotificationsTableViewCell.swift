//
//  NotificationsTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/4/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
struct NotificationsTableViewData {
    
    init(name: String, time:String) {
        self.name = name
        self.time = time
    }
    var name: String
    var time: String
    
}
class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ data: Any?) {
        if let data = data as? NotificationsTableViewData {
            self.nameLabel.text = data.name
            self.timeLabel.text = data.time
        }
    }
    
}

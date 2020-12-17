//
//  AlarmRepeatCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class AlarmRepeatCell: UITableViewCell {
    static let identifier = "AlarmRepeatCell"
    
    @IBOutlet weak var repeatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setRepeatLabel(label: [String]) {
        var str = " "
        if label.isEmpty {
            repeatLabel.text = "안 함"
        } else {
            for t in label {
                str = str + "\(t) "
            }
            repeatLabel.text = str
        }
    }
}

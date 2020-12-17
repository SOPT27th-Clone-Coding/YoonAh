//
//  SleepAlarmCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class SleepAlarmCell: UITableViewCell {
    static let identifier = "SleepAlarmCell"

    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var actionButton: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setEditButton()
    }
    
    private func setEditButton() {
        editButton.layer.masksToBounds = true
        editButton.layer.cornerRadius = 10
    }
    
    func setUpAlarm() {
        alarmLabel.text = "알람 있음"
        alarmLabel.textColor = .white
        editButton.isHidden = true
    }
    
    @IBAction func touchUpEdit(_ sender: Any) {
        actionButton?()
    }
}

//
//  AlarmCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class AlarmCell: UITableViewCell {
    static let identifier = "AlarmCell"
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var dayAndNightLabel: UILabel!
    @IBOutlet weak var alarmTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAlarm(alarm: Alarm) {
        alarmTimeLabel.text = alarm.alarmTime
        dayAndNightLabel.text = alarm.dayAndNight
    }
    
    @IBAction func touchUpSwitch(_ sender: Any) {
        if alarmSwitch.isOn {
            alarmTimeLabel.textColor = .white
            dayAndNightLabel.textColor = .white
            alarmTextLabel.textColor = .white
        }
        else {
            alarmTimeLabel.textColor = .gray
            dayAndNightLabel.textColor = .gray
            alarmTextLabel.textColor = .gray
        }
    }
}

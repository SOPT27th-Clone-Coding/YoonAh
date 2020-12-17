//
//  SleepAlarmEditVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class SleepAlarmEditVC: UIViewController {
    @IBOutlet weak var appSettingButton: UIButton!
    
    var setSleepAlarm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppSettingButton()
    }
    
    private func setAppSettingButton() {
        appSettingButton.layer.masksToBounds = true
        appSettingButton.layer.cornerRadius = 20
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSetting(_ sender: Any) {
        setSleepAlarm?()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNotSetting(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

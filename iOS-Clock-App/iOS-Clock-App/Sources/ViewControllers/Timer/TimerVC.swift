//
//  TimerVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/14.
//

import UIKit

class TimerVC: UIViewController {
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var musicSelectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 35
        cancelButton.isEnabled = false
        
        startButton.setTitle("시작", for: .normal)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 35
        
        musicSelectView.layer.masksToBounds = true
        musicSelectView.layer.cornerRadius = 8
    }
}

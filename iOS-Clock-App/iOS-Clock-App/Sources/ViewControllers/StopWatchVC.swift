//
//  StopWatchVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/09.
//

import UIKit

class StopWatchVC: UIViewController {
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lapRecordTableView: UITableView!
    
    var isStart: Bool = false
    var timer: Timer?
    let timeSelector: Selector = #selector(StopWatchVC.updateTime)
    var currentTimeCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStopwatch()
    }
    
    func setUpStopwatch() {
        stopwatchLabel.text = timeFormatter(0)
        decimalLabel.text = timeFormatterSec(0)
        
        lapButton.setTitle("랩", for: .normal)
        lapButton.layer.masksToBounds = true
        lapButton.layer.cornerRadius = 35
        lapButton.isEnabled = false
        
        startButton.setTitle("시작", for: .normal)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 35
    }
    
    func timeFormatter(_ intTime: Int) -> String {
        let hour = intTime / 3600
        let min = (intTime % 3600) / 60
        
        let hourStr =  hour < 10 ? "0\(hour)" :String(hour)
        let minStr = min < 10 ? "0\(min)" : String(min)
        
        return "\(hourStr):\(minStr)."
    }
    
    func timeFormatterSec(_ intTime: Int) -> String {
        let sec = (intTime % 3600) % 60
        
        let secStr = sec < 10 ? "0\(sec)" : String(sec)
        
        return "\(secStr)"
    }
    
    @objc func updateTime(){
        currentTimeCount += 1
        stopwatchLabel.text = timeFormatter(currentTimeCount)
        decimalLabel.text = timeFormatterSec(currentTimeCount)
    }
    
    @IBAction func touchUpLap(_ sender: Any) {
    }
    
    @IBAction func touchUpStart(_ sender: Any) {
        if isStart == false {
            isStart = true
            lapButton.isEnabled = true
            startButton.setTitle("중단", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 255/255, green: 38/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 148/255, green: 17/255, blue: 0, alpha: 1)
            
            stopwatchLabel.text = timeFormatter(currentTimeCount)
            decimalLabel.text = timeFormatterSec(currentTimeCount)
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        }
    }
}

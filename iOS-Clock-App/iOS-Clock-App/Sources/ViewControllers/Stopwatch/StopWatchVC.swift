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
    var isLap: Bool = false
    var timer: Timer?
    let timeSelector: Selector = #selector(StopWatchVC.updateTime)
    var currentTimeCount: Int = 0
    var currentLapTimeCount: Int = 0
    var lapTimerString: String?
    
    var timeLap: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapRecordTableView.delegate = self
        lapRecordTableView.dataSource = self
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
        lapTimerString = timeFormatter(currentTimeCount) + timeFormatterSec(currentTimeCount)
    }
    
    @IBAction func touchUpLap(_ sender: Any) {
        if isLap {
            timeLap.append(lapTimerString ?? " ")
            lapRecordTableView.reloadData()
        } else {
            timer?.invalidate()
            isStart = false
            currentTimeCount = 0
            timeLap.removeAll()
            lapRecordTableView.reloadData()
            
            lapButton.setTitle("랩", for: .normal)
            lapButton.isEnabled = false
            
            stopwatchLabel.text = timeFormatter(0)
            decimalLabel.text = timeFormatterSec(0)
        }
    }
    
    @IBAction func touchUpStart(_ sender: Any) {
        if isStart == false {
            isLap = true
            isStart = true
            lapButton.isEnabled = true
            startButton.setTitle("중단", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 255/255, green: 38/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 148/255, green: 17/255, blue: 0, alpha: 1)
            
            stopwatchLabel.text = timeFormatter(currentTimeCount)
            decimalLabel.text = timeFormatterSec(currentTimeCount)
            
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        } else if isStart && timer!.isValid {
            isLap = false
            startButton.setTitle("시작", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
            lapButton.setTitle("재설정", for: .normal)
            timer?.invalidate()
        } else if isStart && !(timer!.isValid) {
            isLap = true
            startButton.setTitle("중단", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 255/255, green: 38/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 148/255, green: 17/255, blue: 0, alpha: 1)
            lapButton.setTitle("랩", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        }
    }
}

extension StopWatchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timeLap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.identifier) as? RecordCell else {
            return UITableViewCell()
        }
        timeLap.sort(by: { $0 > $1 })
        let cellItem = self.timeLap[indexPath.row]
        cell.labCountLabel.text = "랩 \(timeLap.count - indexPath.row)"
        cell.labRecordLabel.text = cellItem
        return cell
    }
    
    
}

extension StopWatchVC: UITableViewDelegate {
    
}

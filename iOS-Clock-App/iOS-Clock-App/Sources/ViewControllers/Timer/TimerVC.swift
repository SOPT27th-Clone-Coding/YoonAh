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
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var CircularProgress: CircularProgressView!
    
    var isStart: Bool = false
    var alarmTime: String?
    var timer: Timer?
    let timeSelector: Selector = #selector(TimerVC.updateTime)
    var currentTimeCount = 0
    var totalTime = 0
    var cP: CircularProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        timerLabel.isHidden = true
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 35
        cancelButton.isEnabled = false
        
        startButton.setTitle("시작", for: .normal)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 35
        
        musicButton.layer.masksToBounds = true
        musicButton.layer.cornerRadius = 8
        
        setCircularProgress()
    }
    
    func setCircularProgress() {
        CircularProgress.isHidden = true
        CircularProgress.trackColor = UIColor.darkGray
        CircularProgress.progressColor = UIColor.orange
        CircularProgress.tag = 101
    }
    
    func AlertAlarm(title : String, message : String, text : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: text, style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(okButton)
        
        return self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func animateProgress() {
        cP = self.view.viewWithTag(101) as? CircularProgressView
        cP?.setCurrentProgress(duration: TimeInterval(Float(totalTime)), value: Float(currentTimeCount/totalTime))
    }
    
    func timeFormatter(_ intTime: Int) -> String {
        let hour = intTime / 3600
        let min = (intTime % 3600) / 60
        let sec = (intTime % 3600) % 60
        
        let hourStr =  hour < 10 ? "0\(hour)" :String(hour)
        let minStr = min < 10 ? "0\(min)" : String(min)
        let secStr = sec < 10 ? "0\(sec)" : String(sec)
        
        return "\(hourStr):\(minStr):\(secStr)"
    }
    
    func timeSetUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        alarmTime = dateFormatter.string(from: timePicker.date) + ":00"
        timerLabel.text = alarmTime ?? " "
        
        let alarmArray = alarmTime?.components(separatedBy: ":")
        var times: [Int] = []
        
        guard let hourTime = alarmArray?[0], let minTime = alarmArray?[1] else {
            return
        }
        
        times.append(Int(hourTime) ?? 0)
        times.append(Int(minTime) ?? 0)
        
        totalTime = 60 * times[1] + 3600 * times[0]
        currentTimeCount = 60 * times[1] + 3600 * times[0]
    }
    
    @objc func updateTime(){
        currentTimeCount -= 1
        timerLabel.text = timeFormatter(currentTimeCount)
        CircularProgress.reloadInputViews()
        if currentTimeCount == 0 {
            isStart = false
            timePicker.isHidden = false
            timerLabel.isHidden = true
            CircularProgress.isHidden = true
            
            currentTimeCount = 0
            timer?.invalidate()
            
            startButton.setTitle("시작", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
            
            AlertAlarm(title: "타이머 종료", message: "지정한 시간이 완료되었습니다", text: "확인")
        }
    }
    
    @IBAction func touchUpStart(_ sender: Any) {
        if isStart == false {
            timeSetUp()
            
            isStart = true
            timePicker.isHidden = true
            timerLabel.isHidden = false
            CircularProgress.isHidden = false
            
            cancelButton.isEnabled = true
            
            startButton.setTitle("일시 정지", for: .normal)
            startButton.backgroundColor = UIColor.init(red: 244/255, green: 134/255, blue: 60/255, alpha: 1)
            startButton.setTitleColor(UIColor.init(red: 248/255, green: 209/255, blue: 129/255, alpha: 1), for: .normal)

            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
            
            self.perform(#selector(animateProgress), with: nil, afterDelay: 0.0)
        } else if isStart && timer!.isValid {
            startButton.setTitle("재개", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
            timer?.invalidate()
            
        } else if isStart && !(timer!.isValid) {
            startButton.setTitle("일시 정지", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 248/255, green: 209/255, blue: 129/255, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 244/255, green: 134/255, blue: 60/255, alpha: 1)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        timePicker.isHidden = false
        timerLabel.isHidden = true
        CircularProgress.isHidden = true
        
        timer?.invalidate()
        isStart = false
        cancelButton.isEnabled = false
        currentTimeCount = 0
        
        timerLabel.text = timeFormatter(0)
        
        startButton.setTitle("시작", for: .normal)
        startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
        startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
    }
    
    @IBAction func touchUpMusicSelect(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "TimerMusicVC") as? TimerMusicVC else {
            return
        }
        dvc.sendData = { data in
            self.musicLabel.text = data[0]
        }
        dvc.modalPresentationStyle = .pageSheet
        present(dvc, animated: true, completion: nil)
    }
}

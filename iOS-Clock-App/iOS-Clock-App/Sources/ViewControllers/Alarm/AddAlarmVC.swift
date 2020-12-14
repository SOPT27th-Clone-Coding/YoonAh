//
//  AddAlarmVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class AddAlarmVC: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmTableView: UITableView!
    
    var sampleData: [String] = []
    var sampleSong: [String] = []
    var lavelString: String?
    
    var saveData: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setUp()
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUp() {
        alarmTableView.separatorColor = .darkGray
        UILabel.appearance(whenContainedInInstancesOf: [UIDatePicker.self]).textColor = UIColor.darkGray
    }
    
    func dateLoad() {
        let currentTime = Date()
        let interval = 30
        self.getInitialTime(currentTime: currentTime, interval: interval)
    }
    
    func getInitialTime(currentTime: Date, interval: Int) {
        var components = Calendar.current.dateComponents([.minute, .hour], from: currentTime)
        let minute = components.minute
        let remainder = ceil(Float(minute!/interval))
        let finalMinutes = Int(remainder * Float(interval)) + interval
        components.setValue(finalMinutes, for: .minute)
        guard let finalTime = Calendar.current.date(from: components) else { return }
        self.getDate(date: finalTime)
    }
    
    func getDate(date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "a HH:mm"
        let alarmTime = dateFormatter.string(from: date)
        saveData?(alarmTime)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSave(_ sender: Any) {
        self.getDate(date: datePicker.date)
    }
}

extension AddAlarmVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmRepeatCell.identifier) as? AlarmRepeatCell else {
                return UITableViewCell()
            }
            cell.setRepeatLabel(label: sampleData)
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmLavelCell.identifier) as? AlarmLavelCell else {
                return UITableViewCell()
            }
            cell.setLavel(lavel: lavelString ?? "알람")
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmSoundCell.identifier) as? AlarmSoundCell else {
                return UITableViewCell()
            }
            cell.setLabel(song: sampleSong)
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmAgainCell.identifier) as? AlarmAgainCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension AddAlarmVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let dvc = self.storyboard?.instantiateViewController(identifier:
            "AlarmRepeatVC") as? AlarmRepeatVC else {
                return
            }
            sampleData.removeAll()
            dvc.saveDateData = { date in
                self.sampleData.append(contentsOf: date)
                self.alarmTableView.reloadData()
            }
            dvc.title = "반복"
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else if indexPath.section == 1 {
            guard let dvc = self.storyboard?.instantiateViewController(identifier:
            "AlarmLavelVC") as? AlarmLavelVC else {
                return
            }
            dvc.saveTextFieldData = { text in
                self.lavelString = text
                self.alarmTableView.reloadData()
            }
            dvc.title = "레이블"
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        else if indexPath.section == 2 {
            guard let dvc = self.storyboard?.instantiateViewController(identifier:
            "AlarmSoundVC") as? AlarmSoundVC else {
                return
            }
            sampleSong.removeAll()
            dvc.saveSongs = { song in
                self.sampleSong.append(contentsOf: song)
                self.alarmTableView.reloadData()
            }
            dvc.title = "사운드"
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

//
//  AlarmVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit
import SnapKit

class AlarmVC: UIViewController {
    @IBOutlet weak var alarmTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    var alarm: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetAlarmData()
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
    }
    
    func SetAlarmData() {
        alarm.append(contentsOf: [
            Alarm(dayAndNight: "오전", alarmTime: "6:00"),
            Alarm(dayAndNight: "오전", alarmTime: "6:30"),
            Alarm(dayAndNight: "오전", alarmTime: "7:00"),
            Alarm(dayAndNight: "오전", alarmTime: "7:30"),
            Alarm(dayAndNight: "오전", alarmTime: "8:00"),
            Alarm(dayAndNight: "오전", alarmTime: "8:30")
        ])
    }
    
    @IBAction func touchUpEdit(_ sender: Any) {
        if editButton.titleLabel?.text == "편집" {
            editButton.setTitle("완료", for: .normal)
            alarmTableView.setEditing(true, animated: true)
        }
        if editButton.titleLabel?.text == "완료" {
            editButton.setTitle("편집", for: .normal)
            alarmTableView.setEditing(false, animated: true)
        }
    }
    
    @IBAction func touchUpAdd(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "AddAlarmVC") as? AddAlarmVC else {
            return
        }
        let vc = UINavigationController(rootViewController: dvc)
        vc.modalPresentationStyle = .pageSheet
        dvc.saveData = { time in
            var timeArray = time.components(separatedBy: " ")
            var dayNnight: String = " "
            
            if timeArray[0] == "AM" {
                dayNnight = "오전"
            } else if timeArray[0] == "PM" {
                dayNnight = "오후"
            }
            
            var alarmArray = timeArray[1].components(separatedBy: ":")
            alarmArray[0] = "\(atoi(alarmArray[0]) % 12)"
            timeArray[1] = "\(alarmArray[0]):\(alarmArray[1])"
            
            self.alarm.append(Alarm(dayAndNight: "\(dayNnight)", alarmTime:"\(timeArray[1])"))
            self.alarmTableView.reloadData()
        }
        present(vc, animated: true, completion: nil)
    }
}

extension AlarmVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "수면|기상"
        }
        return "기타"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 56
        }
        return 66
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return alarm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SleepAlarmCell.identifier) as? SleepAlarmCell else {
                return UITableViewCell()
            }
            cell.actionButton = {
                guard let dvc = self.storyboard?.instantiateViewController(identifier: "SleepAlarmEditVC") as? SleepAlarmEditVC else {
                    return
                }
                dvc.setSleepAlarm = {
                    cell.setUpAlarm()
                }
                dvc.modalPresentationStyle = .pageSheet
                self.present(dvc, animated: true, completion: nil)
            }
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.identifier) as? AlarmCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setAlarm(alarm: alarm[indexPath.row])
        return cell
    }
}

extension AlarmVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if (editingStyle == .delete) {
                alarm.remove(at: indexPath.row)
                alarmTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

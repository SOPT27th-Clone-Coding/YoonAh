//
//  AlarmRepeatVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class AlarmRepeatVC: UIViewController {
    @IBOutlet weak var repeatTableView: UITableView!
    
    var saveDateData: (([String]) -> Void)?
    
    var date: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var selectDate: [Bool] = [false, false, false, false, false, false, false]
    var saveDate: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repeatTableView.delegate = self
        repeatTableView.dataSource = self
        setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent
        {
            saveDateData?(saveDate)
        }
    }
    
    func setUp() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension AlarmRepeatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepeatCell.identifier) as? RepeatCell else {
            return UITableViewCell()
        }
        cell.setLabel(date: date[indexPath.row])
        return cell
    }
}

extension AlarmRepeatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectDate[indexPath.row] == false {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
                cell.tintColor = .orange
                saveDate.append(date[indexPath.row])
            }
        } else {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
                if !(saveDate.isEmpty) {
                    saveDate.remove(at: indexPath.row)
                }
            }
        }
    }
}

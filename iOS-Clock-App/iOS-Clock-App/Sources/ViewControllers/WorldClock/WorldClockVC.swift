//
//  WorldClockVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/11/28.
//

import UIKit
import SnapKit

class WorldClockVC: UIViewController {
    @IBOutlet weak var worldClockTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    var headerView = UIView()
    var headerLabel = UILabel()
    
    var time: [WorldTime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimeData()
        setUpHeader()
        worldClockTableView.delegate = self
        worldClockTableView.dataSource = self
    }
    
    func setTimeData() {
        time.append(contentsOf: [
            WorldTime(startWord: "ㅅ", country: "서울", timeDifference: "+0", dayAndNight: "오전", time: "1:48")
        ])
    }
    
    func setUpHeader() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 55))
        headerLabel = UILabel(frame: headerView.bounds)
        headerView.addSubview(headerLabel)
        headerLabel.text = "세계 시계"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        headerLabel.textColor = .white
        headerLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(25)
        }
        
        worldClockTableView.tableHeaderView = headerView
    }
    
    @IBAction func touchUpAdd(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "AddWorldClockVC") as? AddWorldClockVC else {
            return
        }
        dvc.sendCountryData = { country in
            self.time.append(country)
            self.worldClockTableView.reloadData()
        }
        
        dvc.modalPresentationStyle = .pageSheet
        present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func touchUpEdit(_ sender: Any) {
        if editButton.titleLabel?.text == "편집" {
            editButton.setTitle("완료", for: .normal)
            worldClockTableView.setEditing(true, animated: true)
        }
        if editButton.titleLabel?.text == "완료" {
            editButton.setTitle("편집", for: .normal)
            worldClockTableView.setEditing(false, animated: true)
        }
    }
}

extension WorldClockVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldClockCell.identifier) as? WorldClockCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setUpClock(world: time[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(78)
    }
}

extension WorldClockVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == 0) {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (indexPath.row != 0) {
            if (editingStyle == .delete) {
                time.remove(at: indexPath.row)
                worldClockTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

//
//  TimerMusicVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/14.
//

import UIKit

class TimerMusicVC: UIViewController {
    @IBOutlet weak var musicTableView: UITableView!
    
    var sendData: (([String]) -> ())?
    
    var musics: [String] = ["전파 탐지기", "공상음", "공지음", "녹차", "놀이 시간", "느린 상승", "도입음", "물결", "반짝반짝", "발산", "밤부엉이", "별자리", "상승음", "순환음", "신호", "신호음", "실크", "우주", "일루미네이트", "절정", "정점", "차임벨", "크리스탈", "파장", "프레스토", "해변가", "희망", "클래식"]
    var selectDate: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var saveDate: [String] = []
    var indexs: Int = 0
    var deleteCell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicTableView.delegate = self
        musicTableView.dataSource = self
    }
    
    @IBAction func touchUpSet(_ sender: Any) {
        sendData?(saveDate)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension TimerMusicVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier) as? MusicCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.musicLabel.text = musics[indexPath.row]
        return cell
    }
}

extension TimerMusicVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectDate[indexPath.row] == false {
            if let cell = tableView.cellForRow(at: indexPath) {
                selectDate[indexPath.row] = true
                cell.accessoryType = .checkmark
                cell.tintColor = .orange
                saveDate.append(musics[indexPath.row])
                if saveDate.count == 2 {
                    saveDate.removeFirst()
                    selectDate[indexs] = false
                    deleteCell?.accessoryType = .none
                }
                deleteCell = cell
                indexs = indexPath.row
            }
        } else {
            if let cell = tableView.cellForRow(at: indexPath) {
                selectDate[indexPath.row] = false
                cell.accessoryType = .none
                saveDate.removeFirst()
            }
        }
    }
}

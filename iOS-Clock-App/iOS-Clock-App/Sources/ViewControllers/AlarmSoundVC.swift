//
//  AlarmSoundVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/07.
//

import UIKit

class AlarmSoundVC: UIViewController {
    @IBOutlet weak var soundTableView: UITableView!
    
    var saveSongs: (([String]) -> Void)?
    
    var song: [String] = ["없음", "신호등", "녹차", "일루미네이트", "실크", "우주", "정점", "절정", "해변가", "희망", "클래식", "크리스탈", "파장", "차임벨", "프레스토"]
    var saveSong: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundTableView.delegate = self
        soundTableView.dataSource = self
        saveSong.removeAll()
        setUp()
    }
    
    func setUp() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension AlarmSoundVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoundCell.identifier) as? SoundCell else {
            return UITableViewCell()
        }
        cell.setSongLabel(song: song[indexPath.row])
        return cell
    }
}

extension AlarmSoundVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveSong.append(song[indexPath.row]);
        saveSongs?(saveSong)
        self.navigationController?.popViewController(animated: true)
    }
}

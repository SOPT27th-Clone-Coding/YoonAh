//
//  AddWorldClockVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/11/29.
//

import UIKit

class AddWorldClockVC: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var countryTableView: UITableView!
    
    var sendCountryData: ((WorldTime) -> ())?
    
    private var countrys: [WorldTime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimeData()
        setCountryTableView()
    }
    
    private func setCountryTableView() {
        countryTableView.delegate = self
        countryTableView.dataSource = self
    }
    
    private func setTimeData(){
    countrys.append(contentsOf: [
        WorldTime(startWord: "ㅂ", country: "보츠와나", timeDifference: "-10", dayAndNight: "오후", time: "10:48"),
        WorldTime(startWord: "ㅍ", country: "팔레스타인", timeDifference: "+10", dayAndNight: "오전", time: "11:48"),
        WorldTime(startWord: "ㄱ", country: "괌", timeDifference: "-10", dayAndNight: "오후", time: "10:48"),
        WorldTime(startWord: "ㅅ", country: "서울", timeDifference: "+0", dayAndNight: "오전", time: "1:48"),
        WorldTime(startWord: "ㅇ", country: "일본", timeDifference: "+0", dayAndNight: "오전", time: "12:48"),
        WorldTime(startWord: "ㅈ", country: "중국", timeDifference: "+0", dayAndNight: "오전", time: "1:48"),
        WorldTime(startWord: "ㅅ", country: "시카고", timeDifference: "+0", dayAndNight: "오후", time: "10:48"),
        WorldTime(startWord: "ㅂ", country: "브라질", timeDifference: "-1", dayAndNight: "오전", time: "12:48"),
        WorldTime(startWord: "ㅊ", country: "체코", timeDifference: "-5", dayAndNight: "오후", time: "7:48"),
        WorldTime(startWord: "ㄷ", country: "독일", timeDifference: "-10", dayAndNight: "오후", time: "3:48"),
        WorldTime(startWord: "ㅇ", country: "영국", timeDifference: "-11", dayAndNight: "오후", time: "2:48"),
        WorldTime(startWord: "ㅂ", country: "벨기에", timeDifference: "-10", dayAndNight: "오후", time: "3:48"),
        WorldTime(startWord: "ㅂ", country: "부산", timeDifference: "+0", dayAndNight: "오전", time: "1:48"),
        WorldTime(startWord: "ㅂ", country: "베트남", timeDifference: "-4", dayAndNight: "오후", time: "11:48"),
        WorldTime(startWord: "ㅇ", country: "이란", timeDifference: "-4", dayAndNight: "오후", time: "11:48"),
        WorldTime(startWord: "ㅂ", country: "보라카이", timeDifference: "-1", dayAndNight: "오전", time: "12:48"),
        WorldTime(startWord: "ㅇ", country: "인도", timeDifference: "-4", dayAndNight: "오후", time: "10:48")
        ])
    }
}

extension AddWorldClockVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let character = Array(Set(self.countrys.map{ $0.startWord })).sorted()[section]
        return self.countrys.filter{ $0.startWord == character }.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(Set(self.countrys.map{ $0.startWord })).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerLabel = UILabel()
        headerLabel.text = String(Array(Set(self.countrys.map{ $0.startWord})).sorted()[section])
        return headerLabel.text
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = Array(Set(self.countrys.map{ $0.startWord })).sorted()[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryClockCell.identifier) as? CountryClockCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.countryLabel.text = self.countrys.filter{ $0.startWord == character }[indexPath.row].country
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 78/255, green: 78/255, blue: 79/255, alpha: 1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
}

extension AddWorldClockVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = Array(Set(self.countrys.map{ $0.startWord })).sorted()[indexPath.section]
        let counties = self.countrys.filter{ $0.startWord == character }[indexPath.row]
        sendCountryData?(counties)
        dismiss(animated: true, completion: nil)
    }
}

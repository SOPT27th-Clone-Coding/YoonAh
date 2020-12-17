//
//  AlarmLavelCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class AlarmLavelCell: UITableViewCell {
    static let identifier = "AlarmLavelCell"
    
    @IBOutlet weak var lavelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLavel(lavel: String) {
        lavelLabel.text = lavel
    }
}

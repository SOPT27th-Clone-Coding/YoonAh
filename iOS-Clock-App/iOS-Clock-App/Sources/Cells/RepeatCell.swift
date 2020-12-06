//
//  RepeatCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class RepeatCell: UITableViewCell {
    static let identifier = "RepeatCell"

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLabel(date: String) {
        dateLabel.text = "\(date)요일마다"
    }
}

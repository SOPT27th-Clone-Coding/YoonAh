//
//  RecordCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/10.
//

import UIKit

class RecordCell: UITableViewCell {
    static let identifier = "RecordCell"
    
    @IBOutlet weak var labCountLabel: UILabel!
    @IBOutlet weak var labRecordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

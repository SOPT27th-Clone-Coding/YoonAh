//
//  MusicCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/14.
//

import UIKit

class MusicCell: UITableViewCell {
    static let identifier = "MusicCell"

    @IBOutlet weak var musicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//
//  SoundCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/07.
//

import UIKit

class SoundCell: UITableViewCell {
    static let identifier = "SoundCell"

    @IBOutlet weak var songLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSongLabel(song: String) {
        songLabel.text = song
    }

}

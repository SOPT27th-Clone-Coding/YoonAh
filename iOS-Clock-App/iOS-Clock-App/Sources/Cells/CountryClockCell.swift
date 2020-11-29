//
//  CountryClockCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/11/29.
//

import UIKit

class CountryClockCell: UITableViewCell {
    static let identifier = "CountryClockCell"
    @IBOutlet weak var countryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

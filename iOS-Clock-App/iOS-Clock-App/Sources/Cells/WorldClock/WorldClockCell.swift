//
//  WorldClockCell.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/11/28.
//

import UIKit

class WorldClockCell: UITableViewCell {
    static let identifier = "WorldClockCell"
    
    @IBOutlet weak var timeDifferenceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dayAndNightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpClock(world: WorldTime) {
        countryLabel.text = world.country
        dayAndNightLabel.text = world.dayAndNight
        timeLabel.text = world.time
        timeDifferenceLabel.text = "오늘, \(world.timeDifference)시간"
    }
}

//
//  LeaderboardTableViewCell.swift
//  QuizApp
//
//  Created by Luc on 16/06/2019.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.positionLabel.text = ""
        self.usernameLabel.text = ""
        self.scoreLabel.text = ""
    }
    
    func populateCell(scoreData: ScoreCellModel) {
        self.positionLabel.text = scoreData.position
        self.usernameLabel.text = scoreData.username
        self.scoreLabel.text = scoreData.score
    }
    
}

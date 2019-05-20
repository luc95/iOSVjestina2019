//
//  QuizTableViewCell.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    private final let quizService = QuizService()

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        difficultyLabel.text = ""
        descriptionLabel.text = ""
        quizImageView?.image = nil
    }
    
    func populateCell(quizData: QuizCellModel) {
        titleLabel.text = quizData.title
        descriptionLabel.text = quizData.description
        difficultyLabel.text = quizData.level
        
        if let imageURL = quizData.imageURL {
            quizService.fetchQuizImage(urlString: imageURL, completion: {(image) in
                DispatchQueue.main.async {
                    if let image = image {
                        self.quizImageView.image = image
                    }
                }
            })
        }
    }
    
}

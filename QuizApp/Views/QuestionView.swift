//
//  QuestionView.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import UIKit

class QuestionView: UIView {

    private var questionData: Question?
    
    @IBOutlet var questionView: UIView!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func answerClicked(_ sender: Any) {
        if let button = sender as? UIButton {
            print(button.tag)
            button.backgroundColor =
                button.tag == self.question?.correctAnswer ? .green : .red
            self.answerButtons.forEach({$0.isEnabled = false})
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)
        addSubview(questionView)
        questionView.frame = bounds
        questionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    

    var question: Question? {
        get {
            return self.questionData
        }
        set(question) {
            self.questionData = question
            self.questionLabel.text = question?.question
            self.answerButtons.enumerated().forEach {
                $1.setTitle(question?.answers[$0], for: .normal)
                $1.tag = $0
                $1.backgroundColor = .clear
                $1.isEnabled = true
            }
        }
    }
}

//
//  QuestionView.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import UIKit

protocol QuestionViewDelegate: class {
    func questionAnswered(isCorrectAnswer: Bool)
}

class QuestionView: UIView {

    private var questionData: Question?
    
    weak var delegate: QuestionViewDelegate?
    
    @IBOutlet var questionView: UIView!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func answerClicked(_ sender: Any) {
        if let button = sender as? UIButton, let questionData = self.questionData {
            let isCorrectAnswer = button.tag == questionData.correctAnswer
            button.backgroundColor = isCorrectAnswer ? .green : .red
            self.answerButtons.forEach({$0.isEnabled = false})
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                self.delegate?.questionAnswered(isCorrectAnswer: isCorrectAnswer)
            })
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
    
    func fillWithData(question: Question) {
        questionData = question
        questionLabel.text = question.question
        answerButtons.enumerated().forEach {
            $1.setTitle(question.answers[$0], for: .normal)
            $1.tag = $0
            $1.backgroundColor = .clear
            $1.isEnabled = true
        }
    }
   
}

//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import UIKit

class QuizViewController: UIViewController {
    
    private final let quizService = QuizService()
    var questionView: QuestionView?
    
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var questionViewContainer: UIView!
    
    
    @IBAction func fetchData(_ sender: UIButton) {
        quizService.fetchQuizzes(completion: { (quizzes) in
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.setFunFactLabel(quizzes: quizzes)
                    
                    let quiz = quizzes.randomElement()
                    self.setQuizData(quiz: quiz)
                    
                    let question = quiz?.questions.randomElement()
                    self.setQuestionData(question: question)
                } else {
                    self.showError(message: "Error occured while fetching data...")

                }
            }
        })
    }
    
    private func setFunFactLabel(quizzes: [Quiz]) {
        let noOfNBAQuestions = (quizzes.map{ $0.questions }.flatMap{ $0 }.filter{ $0.question.contains("NBA")}).count
        
        self.funFactLabel.text = "FUN FACT: There are \(noOfNBAQuestions) questions that contain the word NBA in it!"
        self.funFactLabel.sizeToFit()
//        self.funFactLabel.lineBreakMode = .byWordWrapping
//        self.funFactLabel.numberOfLines = 3
        self.funFactLabel.center.x = self.view.center.x

    }
    
    private func setQuizData(quiz: Quiz?) {
        self.titleLabel.text = quiz?.title
        self.titleLabel.sizeToFit()
        self.titleLabel.backgroundColor = quiz?.category.color
        self.titleLabel.center.x = self.view.center.x
        
        if let imageURL = quiz?.imageUrl {
            quizService.fetchQuizImage(urlString: imageURL, completion: {(image) in
                DispatchQueue.main.async {
                    if let image = image {
                        self.quizImageView.image = image
                        self.quizImageView.center.x = self.view.center.x
                    }
                }
            })
        }
        
    }
    
    private func setQuestionData(question: Question?) {
        if self.questionViewContainer.subviews.count == 0 {
            self.questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize (width: 250, height: 300)))
        }
        if let questionView = self.questionView {
            self.questionViewContainer.addSubview(questionView)
            questionView.question = question
        }
    }
    
    private func showError(message: String) {
        let toastLabel = UILabel(
            frame: CGRect(x: view.frame.size.width / 2 - 75,
                          y: view.frame.size.height - 100,
                          width: 250, height: 50))
        
        toastLabel.text = message
        toastLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.red
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15;
        toastLabel.clipsToBounds = true
        toastLabel.center.x = self.view.center.x
        toastLabel.numberOfLines = 2
        toastLabel.lineBreakMode = .byWordWrapping
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 5.0, delay: 0.3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

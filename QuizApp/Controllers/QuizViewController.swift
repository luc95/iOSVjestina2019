//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import UIKit

class QuizViewController: UIViewController {
    
    private final let quizService = QuizService()

    var viewModel: QuizViewModel!
    
    var answers: [Bool] = []
    var startTime: Date?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var startQuizButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    convenience init(viewModel: QuizViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }
    
    @IBAction func startQuizClicked(_ sender: Any) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        scrollView.isHidden = false
        startQuizButton.isEnabled = false
        startTime = Date()
    }
    
    private func populateView() {
        self.navigationItem.title = viewModel.title
        self.titleLabel.text = viewModel.title
        
        if let imageURL = viewModel.imageUrl {
            quizService.fetchQuizImage(urlString: imageURL, completion: {(image) in
                DispatchQueue.main.async {
                    if let image = image {
                        self.quizImageView.image = image
                    }
                }
            })
        }
        
        let scrollViewWidth = self.scrollView.frame.width
        let totalWidth = scrollViewWidth * CGFloat(viewModel.numberOfQuestions)
        scrollView.contentSize = CGSize(width: totalWidth, height: self.scrollView.frame.height)
        
        viewModel.questions.enumerated().forEach {
            let offset = scrollViewWidth * CGFloat($0)
            let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: offset, y: 0), size: scrollView.frame.size))
            questionView.fillWithData(question: $1)
            questionView.delegate = self
            scrollView.addSubview(questionView)
        }
    }
    
    private func postQuizResults() {
        let quizId = viewModel.id
        let numberOfCorrectAnswers = answers.filter{$0}.count
        var totalTime = Double(Date().timeIntervalSince(startTime!))
        totalTime = (totalTime * 10000).rounded() / 10000
        
        let quizResult = "Score: \(numberOfCorrectAnswers)/\(viewModel.numberOfQuestions). Finished in \(totalTime) secs."
        
        quizService.postQuizResults(
            quizId: quizId,
            time: totalTime,
            numberOfCorrectAnswers: numberOfCorrectAnswers,
            completion: { (httpStatusCode) in
                if let httpStatusCode = httpStatusCode {
                    self.showAlert(httpStatusCode: httpStatusCode, quizResult: quizResult)
                } else {
                    self.showError(message: "Internal server error")
                }
        }
        )
    }
    
    private func showAlert(httpStatusCode: HttpStatusCode, quizResult: String) {
        var title: String = quizResult
        var actions: [UIAlertAction] = []
        
        let cancelAction = UIAlertAction(title: "OK", style: .default) { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        actions.append(cancelAction)
        
        if httpStatusCode != HttpStatusCode.OK {
            let tryAgainAction = UIAlertAction(title: "Try again", style: .default) { (_) in
                self.postQuizResults()
            }
            actions.append(tryAgainAction)
            title = httpStatusCode.name
        }
        
        let alertController = UIAlertController(title: title, message: httpStatusCode.message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
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

extension QuizViewController: QuestionViewDelegate {
    
    func questionAnswered(isCorrectAnswer: Bool) {
        answers.append(isCorrectAnswer)
        
        if answers.count == viewModel.numberOfQuestions {
            postQuizResults()
        } else {
            let offset = scrollView.frame.width * CGFloat(answers.count)
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
}

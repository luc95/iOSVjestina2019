//
//  QuizzesTableViewController.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

import UIKit

class QuizzesTableViewController: UITableViewController {
    
    private var viewModel: QuizzesViewModel!
    
    private let reuseIdentifier = "reuseIdentifier"
    
    convenience init(viewModel: QuizzesViewModel) {
        self.init()
        self.viewModel = viewModel
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchQuizzes {
            self.refresh()
        }
        
        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }

    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Category.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfQuizzes(category: Category.allCases[section])
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! QuizTableViewCell
        
        if let quiz = viewModel.quiz(forIndexPath: indexPath) {
            cell.populateCell(quizData: quiz)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = Category.allCases[section]
        return QuizzesTableSectionHeader(title: category.rawValue, color: category.color)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let quizViewModel = self.viewModel.quizViewModel(forIndexPath: indexPath) {
            let quizViewController = QuizViewController(viewModel: quizViewModel)
            quizViewController.delegate = self
            navigationController?.pushViewController(quizViewController, animated: true)
        }
    }
}

extension QuizzesTableViewController: QuizViewControllerDelegate {
    func leaderboardClicked(quiz id: Int) {
        let leaderboardVC = LeaderboardTableViewController(viewModel: LeaderboardViewModel(quizId: id))
        let leaderboardNVC = UINavigationController(rootViewController: leaderboardVC)
        self.present(leaderboardNVC, animated: true, completion: nil)
    }
}

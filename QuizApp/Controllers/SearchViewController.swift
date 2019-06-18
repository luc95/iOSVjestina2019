//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Luc on 16/06/2019.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var quizzesTableView: UITableView!
    
    private var viewModel: QuizzesViewModel!
    private let reuseIdentifier = "reuseIdentifier"
    private var refreshControl: UIRefreshControl!

    convenience init(viewModel: QuizzesViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchQuizzes {
            self.refresh()
        }
        
        searchBar.delegate = self
        
        quizzesTableView.delegate = self
        quizzesTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SearchViewController.refresh), for: UIControl.Event.valueChanged)
        quizzesTableView.refreshControl = refreshControl
        
        quizzesTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.quizzesTableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchQuizzes(filter: searchText) {
            self.refresh()
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = Category.allCases[section]
        return QuizzesTableSectionHeader(title: category.rawValue, color: category.color)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let quizViewModel = self.viewModel.quizViewModel(forIndexPath: indexPath) {
            let quizViewController = QuizViewController(viewModel: quizViewModel)
            quizViewController.delegate = self
            navigationController?.pushViewController(quizViewController, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfQuizzes(category: Category.allCases[section])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! QuizTableViewCell
        
        if let quiz = viewModel.quiz(forIndexPath: indexPath) {
            cell.populateCell(quizData: quiz)
        }
        
        return cell
    }
}

extension SearchViewController: QuizViewControllerDelegate {
    func leaderboardClicked(quiz id: Int) {
        let leaderboardVC = LeaderboardTableViewController(viewModel: LeaderboardViewModel(quizId: id))
        let leaderboardNVC = UINavigationController(rootViewController: leaderboardVC)
        self.present(leaderboardNVC, animated: true, completion: nil)
    }
}

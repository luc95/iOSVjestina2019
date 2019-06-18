//
//  LeaderboardTableViewController.swift
//  QuizApp
//
//  Created by Luc on 16/06/2019.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    private var viewModel: LeaderboardViewModel!
    
    private let reuseIdentifier = "reuseIdentifier"

    convenience init(viewModel: LeaderboardViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Leaderboard"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeLeaderboard))
        
        viewModel.fetchScores {
            self.refresh()
        }
        
        tableView.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    @objc func closeLeaderboard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfScores
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LeaderboardTableViewCell
        
        if let score = self.viewModel.score(forRow: indexPath.row) {
            cell.populateCell(scoreData: score)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
}

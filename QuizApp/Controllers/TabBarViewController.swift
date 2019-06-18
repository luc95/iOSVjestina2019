//
//  TabBarViewController.swift
//  QuizApp
//
//  Created by Luc on 16/06/2019.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController{
    
    override func viewDidLoad() {
        let quizzesVC = QuizzesTableViewController(viewModel: QuizzesViewModel())
        quizzesVC.navigationItem.title = "Quizzes"
        let quizzesNVC = UINavigationController(rootViewController: quizzesVC)
        quizzesNVC.tabBarItem = UITabBarItem(title: "Quizzes", image: UIImage(named: "quiz"), tag: 0)
        
        let searchVC = SearchViewController(viewModel: QuizzesViewModel())
        searchVC.navigationItem.title = "Search"
        let searchNVC = UINavigationController(rootViewController: searchVC)
        searchNVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)
        
        let settingsVC = SettingsViewController()
        let settingsNVC = UINavigationController(rootViewController: settingsVC)
        settingsNVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 2)
        
        
        self.viewControllers = [quizzesNVC, searchNVC, settingsNVC]
    }
}

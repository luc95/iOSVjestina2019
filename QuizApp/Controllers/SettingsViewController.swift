//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Luc on 16/06/2019.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func logoutClicked(_ sender: Any) {
        LoginUtils.logoutUser()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigateToLoginViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"
        
        usernameLabel.text = LoginUtils.getUsername()
    }


}

//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let quizzesViewController = QuizzesTableViewController(viewModel: QuizzesViewModel())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = LoginUtils.isUserLoggedIn() ? TabBarViewController() : LoginViewController()
        
        window?.rootViewController = rootViewController
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func navigateToTabBarViewController() {
        window?.rootViewController = TabBarViewController()
    }
    
    func navigateToLoginViewController() {
        self.window?.rootViewController = LoginViewController()
    }
    
}


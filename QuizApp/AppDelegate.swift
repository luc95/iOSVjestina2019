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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let quizViewController = QuizViewController()
        
        window?.rootViewController = quizViewController
        
        window?.makeKeyAndVisible()
        
        return true
    }

}


//
//  LoginUtils.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

import UIKit

struct Credentials {
    
    var accessToken: String?
    var userID: Int?
    
    init(accessToken: String, userID: Int) {
        self.accessToken = accessToken
        self.userID = userID
    }
}

class LoginUtils {
    
    private static let TOKEN_KEY = "accessToken"
    private static let USER_ID = "userID"
    
    static func getUserID() -> Int {
        return UserDefaults.standard.integer(forKey: USER_ID)
    }
    
    static func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: TOKEN_KEY)
    }
    
    static func isUserLoggedIn() -> Bool {
        return getAccessToken() != nil
    }
    
    static func loginUser(credentials: Credentials) {
        UserDefaults.standard.set(credentials.accessToken, forKey: TOKEN_KEY)
        UserDefaults.standard.set(credentials.userID, forKey: USER_ID)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigateToQuizzesViewController()
    }
    
}

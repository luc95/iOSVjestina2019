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
    var username: String?
    
    init(accessToken: String, userID: Int, username: String) {
        self.accessToken = accessToken
        self.userID = userID
        self.username = username
    }
}

class LoginUtils {
    
    private static let TOKEN_KEY = "accessToken"
    private static let USER_ID = "userID"
    private static let USERNAME = "username"
    
    static func getUserID() -> Int {
        return UserDefaults.standard.integer(forKey: USER_ID)
    }
    
    static func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: TOKEN_KEY)
    }
    
    static func getUsername() -> String? {
        return UserDefaults.standard.string(forKey: USERNAME)
    }
    
    static func isUserLoggedIn() -> Bool {
        return getAccessToken() != nil
    }
    
    static func loginUser(credentials: Credentials) {
        UserDefaults.standard.set(credentials.accessToken, forKey: TOKEN_KEY)
        UserDefaults.standard.set(credentials.userID, forKey: USER_ID)
        UserDefaults.standard.set(credentials.username, forKey: USERNAME)
    }
    
    static func logoutUser() {
        UserDefaults.standard.removeObject(forKey: TOKEN_KEY)
        UserDefaults.standard.removeObject(forKey: USER_ID)
        UserDefaults.standard.removeObject(forKey: USERNAME)
    }
    
}

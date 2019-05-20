//
//  Category.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import UIKit

enum Category: String, CaseIterable {
    
    case sports = "SPORTS"
    case science = "SCIENCE"
    
    var color: UIColor {
        switch self {
            case .sports:
                return UIColor.blue
            case .science:
                return UIColor.green
        }
    }

}

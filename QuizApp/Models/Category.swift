//
//  Category.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import Foundation
import UIKit

enum Category {
    
    case sports
    case science
    
    var text: String {
        switch self {
        case .sports:
            return "SPORTS"
        case .science:
            return "SCIENCE"
        }
    }
    
    var color: UIColor {
        switch self {
            case .sports:
                return UIColor.blue
            case .science:
                return UIColor.green
        }
    }
    
    static func getCategory(text: String) -> Category? {
        switch text {
            case "SPORTS":
                return .sports
            case "SCIENCE":
                return .science
            default:
                return nil
        }
    }
}

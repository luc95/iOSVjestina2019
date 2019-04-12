//
//  Quiz.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import Foundation

struct Quiz {
    
    let id: Int
    let title: String
    let description: String
    let category: Category
    let level: Int
    let imageUrl: String
    let questions: [Question]
    
    init?(json: Any) {
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"] as? String,
            let categoryText = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let imageUrl = jsonDict["image"] as? String,
            let questions = jsonDict["questions"] as? [Any] {

            self.id = id
            self.title = title
            self.description = description
            
            if let category = Category.getCategory(text: categoryText) {
                self.category = category
            } else {
                return nil
            }
            
            self.level = level
            self.imageUrl = imageUrl
            self.questions = questions.compactMap{ Question(json: $0) }

        } else {
            return nil
        }
    }
    
    
}

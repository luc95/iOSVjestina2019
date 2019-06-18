//
//  Question+CoreDataProperties.swift
//  QuizApp
//
//  Created by Luc on 17/06/2019.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var nsmAnswers: [String]
    @NSManaged public var nsmCorrectAnswer: Int16
    @NSManaged public var nsmId: Int64
    @NSManaged public var nsmQuestion: String
    
    var id: Int {
        get { return Int(nsmId) }
        set { nsmId = Int64(newValue) }
    }
    
    var question: String {
        get { return nsmQuestion }
        set { nsmQuestion = newValue }
    }
    
    var answers: [String] {
        get { return nsmAnswers }
        set { nsmAnswers = newValue }
    }
    
    var correctAnswer: Int {
        get { return Int(nsmCorrectAnswer) }
        set { nsmCorrectAnswer = Int16(newValue) }
    }

}

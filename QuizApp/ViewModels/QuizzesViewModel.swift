//
//  QuizzesViewModel.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

import Foundation

struct QuizCellModel {
    
    let title: String
    let description: String
    let level: String
    let imageURL: String?
    
    init(quiz: Quiz) {
        self.title = quiz.title
        self.description = quiz.description ?? ""
        self.level = String(repeating: "*", count: quiz.level)
        self.imageURL = quiz.imageUrl ?? ""
    }
}

class QuizzesViewModel {
    
    private var quizzes: [Quiz]?
    
    public func numberOfQuizzes(category: Category) -> Int {
        return quizzesByCategory(category: category)?.count ?? 0
    }
    
    public func quizViewModel(forIndexPath indexPath: IndexPath) -> QuizViewModel? {
        let category = Category.allCases[indexPath.section]
        guard let quizzes = quizzesByCategory(category: category) else {
            return nil
        }
        return QuizViewModel(quiz: quizzes[indexPath.row])
    }
    
    public func quiz(forIndexPath indexPath: IndexPath) -> QuizCellModel? {
        let category = Category.allCases[indexPath.section]
        guard let quizzes = quizzesByCategory(category: category) else {
            return nil
        }
        return QuizCellModel(quiz: quizzes[indexPath.row])
    }
    
    public func quizzesByCategory(category: Category) -> [Quiz]? {
        return quizzes?.filter{$0.category == category}
    }
    
    public func fetchQuizzes(completion: @escaping () -> Void) {
        QuizService().fetchQuizzes(completion: { [weak self] (quizzes) in
            self?.quizzes = quizzes
            completion()
        })
    }
    
}

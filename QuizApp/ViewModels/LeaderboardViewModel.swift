//
//  LeaderboardViewModel.swift
//  QuizApp
//
//  Created by Luc on 16/06/2019.
//

struct ScoreCellModel {
    
    let position: String
    let username: String
    let score: String
    
    init(number: Int, score: Score) {
        self.position = "\(number)"
        self.username = score.username
        self.score = String(format: "%.3f", score.score)
    }
}

class LeaderboardViewModel {
    
    private var quizId: Int
    private var scores: [Score]?
    
    init(quizId: Int) {
        self.quizId = quizId
    }
    
    public var numberOfScores: Int {
        return scores?.count ?? 0
    }
    
    public func score(forRow row: Int) -> ScoreCellModel? {
        guard let scores = scores else {
            return nil
        }
        return ScoreCellModel(number: row + 1, score: scores[row])
    }
    
    public func fetchScores(completion: @escaping () -> Void) {
        QuizService().fetchScores(forQuiz: quizId, completion: { [weak self] (scores) in
            self?.scores = scores
            self?.scores?.sort{ $0.score > $1.score }
            completion()
        })
    }
}

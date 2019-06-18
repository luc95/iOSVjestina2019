//
//  QuizService.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import Foundation
import UIKit

class QuizService {
    
    private final let quizzesDataURL = "https://iosquiz.herokuapp.com/api/quizzes"
    private final let resultURLString = "https://iosquiz.herokuapp.com/api/result"
    private final let leaderboardUrlString = "https://iosquiz.herokuapp.com/api/score?quiz_id="

    func fetchQuizzes(completion: @escaping ([Quiz]?) -> Void) {
        if let url = URL(string: quizzesDataURL) {
            let urlRequest = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let dataResponse = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                        if let jsonRoot = jsonResponse as? [String: Any],
                            let quizzesResponse = jsonRoot["quizzes"] as? [Any] {
                            let quizzes = quizzesResponse.compactMap(Quiz.createFrom)
                            completion(quizzes)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
    
    func fetchQuizImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, errror) in
                if let dataResponse = data {
                    let image = UIImage(data: dataResponse)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        }
    }
    
    func postQuizResults(quizId: Int, time: Double, numberOfCorrectAnswers: Int,
                        completion: @escaping ((HttpStatusCode?) -> Void)) {
        if let url = URL(string: resultURLString) {
            var request = URLRequest(url: url)
            
            if let accessToken = LoginUtils.getAccessToken() {
                request.addValue(accessToken, forHTTPHeaderField: "Authorization")
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let parameters: [String: Any] = [
                "quiz_id": quizId, "user_id": LoginUtils.getUserID(),
                "time": time, "no_of_correct": numberOfCorrectAnswers
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                    completion(HttpStatusCode(rawValue: httpResponse.statusCode))
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
    
    func fetchScores(forQuiz id: Int, completion: @escaping (([Score]?) -> Void)) {
        if let url = URL(string: leaderboardUrlString + "\(id)") {
            var request = URLRequest(url: url)
            
            if let accessToken = LoginUtils.getAccessToken() {
                request.addValue(accessToken, forHTTPHeaderField: "Authorization")
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDict = json as? [Any] {
                            let scores = jsonDict.compactMap(Score.init)
                            completion(scores)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
    
}

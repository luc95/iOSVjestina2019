//
//  QuizService.swift
//  QuizApp
//
//  Created by Luc on 11/04/2019.
//

import Foundation
import UIKit

class QuizService {
    
    let quizzesDataURL = "https://iosquiz.herokuapp.com/api/quizzes"
    
    func fetchQuizzes(completion: @escaping ([Quiz]?) -> Void) {
        if let url = URL(string: quizzesDataURL) {
            let urlRequest = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let dataResponse = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                        if let jsonRoot = jsonResponse as? [String: Any],
                            let quizzesResponse = jsonRoot["quizzes"] as? [Any] {
                            let quizzes = quizzesResponse.compactMap{ Quiz(json: $0) }
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
}

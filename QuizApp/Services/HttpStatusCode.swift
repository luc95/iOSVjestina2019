//
//  HttpStatusCode.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

enum HttpStatusCode: Int {
    case OK = 200
    case BAD_REQUEST = 400
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case NOT_FOUND = 404
    
    var name: String {
        return "\(self.rawValue) " + "\(self)".replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
    }
    
    var message: String {
        switch self {
        case .OK:
            return "Quiz results have been successfully sent to the server."
        case .BAD_REQUEST:
            return "An error occurred. Please try again."
        case .UNAUTHORIZED:
            return "User is unauthorized."
        case .FORBIDDEN:
            return "Access token is not associated with user ID."
        case .NOT_FOUND:
            return "Quiz does not exist."
        }
    }
}

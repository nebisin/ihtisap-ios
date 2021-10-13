//
//  APIError.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case invalidURL
    case invalidResponse(statusCode: Int, response: ErrorResponse)
    case validationError(response: ValidationErrorResponse)
    case invalidData(DecodingError?)
    case unableToComplete
    
    var localizedDescription: String {
        switch self {
        case .invalidURL, .invalidData:
            return "Sorry, something went wrong. Please contact to support."
        case .invalidResponse(statusCode: _, response: let response):
            return response.error
        case .unableToComplete:
            return "Unable to complete your request. Please check your internet connection."
        case .validationError(let errs):
            var errsString: String = ""
            errs.errors.forEach { err in
                errsString.append("\(err.key): \(err.value)\n")
            }
            return errsString
        }
    }
    
    var description: String {
        switch self {
        case .unableToComplete: return "unknown error"
        case .invalidURL: return "invalid URL"
        case .invalidResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        case .invalidData(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .validationError(_):
            return "validation error"
            
        }
    }
}

struct ErrorResponse: Codable {
    let error: String
}

struct ValidationErrorResponse: Codable {
    let errors: [String: String]
}

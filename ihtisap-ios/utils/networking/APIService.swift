//
//  APIService.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

let baseURL = "http://localhost:4000/api/v1/"

final class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func http<T: Decodable>(_ type: T.Type, request: URLRequest) async -> (T?, APIError?) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.RFC3399)
            
            if let response = response as? HTTPURLResponse, response.statusCode == 422 {
                let errs = try decoder.decode(ValidationErrorResponse.self, from: data)
                return (nil, .validationError(response: errs))
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                let err = try decoder.decode(ErrorResponse.self, from: data)
                return (nil, .invalidResponse(statusCode: response.statusCode, response: err))
            }
            
            let result = try decoder.decode(type, from: data)
            return (result, nil)
        
        } catch {
            return (nil, .unableToComplete)
        }
    }

}

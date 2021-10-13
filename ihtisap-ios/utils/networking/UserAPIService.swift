//
//  UserAPIService.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

class UserAPIService {
    static let shared = UserAPIService()
    
    private let registerURL = baseURL + "users"
    private let loginURL = baseURL + "users/authenticate"
    private let authURL = baseURL + "users/me"
    
    private init() {}
    
    func register(payload: RegisterRequest) async -> (UserResponse?, APIError?) {
        guard let url = URL(string: registerURL) else {
            return (nil, .invalidURL)
        }
        
        guard let encoded = try? JSONEncoder().encode(payload) else {
            return (nil, .unableToComplete)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        let (data, error) = await APIService.shared.http(UserResponse.self, request: request)
        
        return (data, error)
    }
    
    func login(payload: LoginRequest) async -> (AuthToken?, APIError?) {
        guard let url = URL(string: loginURL) else {
            return (nil, .invalidURL)
        }
        
        guard let encoded = try? JSONEncoder().encode(payload) else {
            return (nil, .unableToComplete)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        let (data, error) = await APIService.shared.http(AuthToken.self, request: request)
        
        return (data, error)
    }
    
    func auth(payload: AuthToken) async -> (UserResponse?, APIError?) {
        guard let url = URL(string: authURL) else {
            return (nil, .invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setValue("Bearer \(payload.authenticationToken)", forHTTPHeaderField: "Authorization")
        
        let (data, error) = await APIService.shared.http(UserResponse.self, request: request)
        
        return (data, error)
    }
}

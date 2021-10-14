//
//  AccountAPIService.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import Foundation

final class AccountAPIService {
    static let shared = AccountAPIService()
    
    private let accountURL = baseURL + "accounts"

    private init() {}

    func createAccount(authToken: String, payload: CreateAccountRequest) async -> (AccountResponse?, APIError?) {
        guard let url = URL(string: accountURL) else {
            return (nil, .invalidURL)
        }
        
        guard let encoded = try? JSONEncoder().encode(payload) else {
            return (nil, .unableToComplete)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        let (data, error) = await APIService.shared.http(AccountResponse.self, request: request)
        
        return (data, error)
    }
    
    func listAccounts(authToken: String) async -> (AccountsResponse?, APIError?) {
        guard let url = URL(string: accountURL) else {
            return (nil, .invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, error) = await APIService.shared.http(AccountsResponse.self, request: request)
        
        return (data, error)
    }
}

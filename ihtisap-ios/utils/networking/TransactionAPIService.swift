//
//  TransactionAPIService.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import Foundation

final class TransactionAPIService {
    static let shared = TransactionAPIService()
    
    private let accountURL = baseURL + "accounts"
    private let transactionURL = baseURL + "transactions"

    private init() {}
    
    func searchTransactions(authToken: String, limit: Int = 20, page: Int = 1, term: String = "") async -> (TransactionsResponse?, APIError?) {
        let searchURL = transactionURL + "?sort=-id&limit=\(limit)&page=\(page)&title=\(term.urlEncoded!)"
        guard let url = URL(string: searchURL) else {
            return (nil, .invalidURL)
        }
                
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, error) = await APIService.shared.http(TransactionsResponse.self, request: request)
        
        return (data, error)
    }

    func listTransactions(authToken: String, accountID: Int, limit: Int = 20, page: Int = 1, sort: String = "-id") async -> (TransactionsResponse?, APIError?) {
        let listTransactionsURL = "\(accountURL)/\(accountID)/transactions?sort=\(sort)&limit=\(limit)&page=\(page)"
        guard let url = URL(string: listTransactionsURL) else {
            return (nil, .invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, error) = await APIService.shared.http(TransactionsResponse.self, request: request)
        
        return (data, error)
    }
    
    func createTransaction(authToken: String, payload: CreateTransactionRequest) async -> (TransactionResponse?, APIError?) {
        guard let url = URL(string: transactionURL) else {
            return (nil, .invalidURL)
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.RFC3399)
        
        print(payload)
        
        guard let encoded = try? encoder.encode(payload) else {
            return (nil, .unableToComplete)
        }
                
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = encoded
        print(encoded)
        
        let (data, error) = await APIService.shared.http(TransactionResponse.self, request: request)
                
        return (data, error)
    }
}

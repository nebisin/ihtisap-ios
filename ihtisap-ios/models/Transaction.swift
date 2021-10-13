//
//  Transaction.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: Int
    let userID: Int
    let accountID: Int
    let type: TransactionType
    let title: String
    let description: String?
    let tags: [String]?
    let amount: Double
    let payday: Date
    let createdAt: Date
    let version: Int
}

struct TransactionResponse: Codable {
    let transaction: Transaction
}

struct TransactionsResponse: Codable {
    let transactions: [Transaction]
}

struct CreateTransactionRequest: Codable {
    var accountID: Int
    var type: TransactionType
    var title: String
    var description: String
    var tags: [String]
    var amount: Double
    var payday: Date
}

enum TransactionType: String, CaseIterable, Identifiable, Codable {
    case income
    case expense
    
    var id: String {self.rawValue}
}

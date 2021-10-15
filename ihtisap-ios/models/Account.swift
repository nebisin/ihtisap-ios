//
//  Account.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

struct Account: Identifiable, Codable {
    var id: Int
    var ownerID: Int
    var title: String
    var description: String?
    var totalIncome: Double
    var totalExpense: Double
    var currency: Currency
    var createdAt: Date
    var version: Int
}

struct AccountResponse: Codable {
    let account: Account
}

struct AccountsResponse: Codable {
    let accounts: [Account]
}

struct CreateAccountRequest: Codable {
    var title: String = ""
    var description: String = ""
    var currency: Currency = .USD
    var initialBalance: Double = 0
}

enum Currency: String, CaseIterable, Identifiable, Codable {
    case USD
    case TRY
    case EUR
    case AUD
    
    var id: String {self.rawValue}
}

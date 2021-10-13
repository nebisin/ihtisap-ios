//
//  Account.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

struct Account: Identifiable, Codable {
    let id: Int
    let ownerID: Int
    let title: String
    let description: String?
    let totalIncome: Double
    let totalExpense: Double
    let currency: String
    let createdAt: Date
    let version: Int
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
    var currency: String = "USD"
    var initialBalance: Double = 0
}

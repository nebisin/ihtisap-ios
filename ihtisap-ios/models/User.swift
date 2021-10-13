//
//  User.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let email: String
    let isActivated: Bool
    let createdAt: Date
    let version: Int
}

struct UserResponse: Codable {
    let user: User
}

struct AuthToken: Codable {
    var authenticationToken: String
}

struct RegisterRequest: Codable {
    var name: String = ""
    var email: String = ""
    var password: String = ""
}

struct LoginRequest: Codable {
    var email: String = ""
    var password: String = ""
}

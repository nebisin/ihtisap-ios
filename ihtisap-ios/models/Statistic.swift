//
//  Statistic.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

struct Statistic: Codable {
    let accountID: Int
    let date: Date
    let earning: Double
    let spending: Double
    let createdAt: Date
    let version: Int
}

struct StatisticsResponse: Codable {
    let statistics: [Statistic]
}

//
//  DashboardAccountStats.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 16.10.2021.
//

import SwiftUI

struct DashboardAccountStats: View {
    let account: Account

    var body: some View {
        HStack {
            VStack {
                Text("Total Expense")
                Text("\(account.totalExpense, specifier: "%.2F") \(account.currency.rawValue)")
            }
            
            Spacer()
            VStack {
                Text("Total Income")
                Text("\(account.totalIncome, specifier: "%.2F") \(account.currency.rawValue)")

            }
        }
        .padding()
    }
}

struct DashboardAccountStats_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DashboardAccountStats(account: Account(id: 0, ownerID: 0, title: "Personel Account", description: "lorem ipsum dolor sit amet", totalIncome: 100, totalExpense: 200, currency: .USD, createdAt: .now, version: 0))
        }
    }
}

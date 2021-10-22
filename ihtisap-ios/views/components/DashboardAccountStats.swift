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
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(account.totalExpense, specifier: "%.2F") \(account.currency.rawValue)")
                    .bold()
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            VStack {
                Text("Total Income")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(account.totalIncome, specifier: "%.2F") \(account.currency.rawValue)")
                    .bold()
                    .foregroundColor(.green)
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

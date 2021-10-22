//
//  DashboardAccountTransactionItem.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 15.10.2021.
//

import SwiftUI

struct AppTransactionItem: View {
    let ts: Transaction
    
    var body: some View {
        HStack{
            VStack (alignment: .leading) {
                Text(ts.title)
                    .padding(.bottom, 5)
                Text(ts.payday, style: .date)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Spacer()
            Text("\(ts.amount, specifier: "%.2F")")
                .foregroundColor(ts.type == .income ? .green : .red)
        }
        .padding()
    }
}

struct AppTransactionItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AppTransactionItem(ts: Transaction(id: 1, userID: 1, accountID: 1, type: .income, title: "Salary", description: "lorem ipsum dolor sit amet", tags: [], amount: 7600, payday: .now, createdAt: .now, version: 1))
            AppTransactionItem(ts: Transaction(id: 1, userID: 1, accountID: 1, type: .expense, title: "Gorocery", description: "lorem ipsum dolor sit amet", tags: [], amount: 102.7, payday: .now, createdAt: .now, version: 1))
            AppTransactionItem(ts: Transaction(id: 1, userID: 1, accountID: 1, type: .expense, title: "Food", description: "lorem ipsum dolor sit amet", tags: [], amount: 33.2, payday: .now, createdAt: .now, version: 1))
        }

    }
}

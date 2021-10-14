//
//  DashboardAccountPicker.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct DashboardAccountPicker: View {
    @Binding var selectedAccount: Int
    let accounts: [Account]
    
    var body: some View {
        ZStack (alignment: .leading) {
            Color.gray
                .opacity(0.2)
                .frame(width: 160, height: 35)
                .cornerRadius(5)
            
            Picker("Select account", selection: $selectedAccount) {
                ForEach(accounts) { account in
                    Text(account.title.count > 20 ? "\(account.title.prefix(17))..." : account.title)
                        .tag(account.id)
                }
            }
            .padding(.horizontal)
            
        }
    }
}

struct DashboardAccountPicker_Previews: PreviewProvider {
    static var previews: some View {
        DashboardAccountPicker(
            selectedAccount: .constant(0),
            accounts: [
                Account(id: 1, ownerID: 0, title: "Personel Account", description: "", totalIncome: 100, totalExpense: 100, currency: .USD, createdAt: Date(), version: 0),
                Account(id: 2, ownerID: 0, title: "Family Account", description: "", totalIncome: 100, totalExpense: 100, currency: .USD, createdAt: Date(), version: 0)
            ]
        )
    }
}

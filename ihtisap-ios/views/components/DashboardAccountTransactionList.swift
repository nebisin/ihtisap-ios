//
//  DashboardAccountTransactionList.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct DashboardAccountTransactionList: View {
    @ObservedObject var store: TransactionStore
    
    var body: some View {
        if store.isLoading {
            AppLoading()
        } else if let error = store.errorMessage {
            Text(error)
        } else if store.lastTransactions.isEmpty {
            Text("No transactions yet")
        } else {
            List(store.lastTransactions) { item in
                Text(item.title)
            }
        }
    }
}

struct DashboardAccountTransactionList_Previews: PreviewProvider {
    static var previews: some View {
        DashboardAccountTransactionList(store: TransactionStore())
    }
}

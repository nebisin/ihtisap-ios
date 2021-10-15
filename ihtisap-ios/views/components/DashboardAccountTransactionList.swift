//
//  DashboardAccountTransactionList.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct DashboardAccountTransactionList: View {
    @ObservedObject var store: TransactionStore
    @EnvironmentObject var accountStore: AccountStore
    
    var body: some View {
        if store.isLoading {
            AppLoading()
        } else if let error = store.errorMessage {
            Text(error)
        } else if store.lastTransactions.isEmpty {
            Text("No transactions yet")
        } else {
            List {
                if let account = accountStore.selectedAccount {
                    Section {
                        DashboardAccountStats(account: account)
                    } footer: {
                        Button("See more statistics") {
                            print("more stats")
                        }
                    }
                }
                Section {
                    ForEach(store.lastTransactions) { item in
                        DashboardAccountTransactionItem(ts: item)
                    }
                } header: {
                    Text("Last Transactions")
                } footer: {
                    Button("See more transaction") {
                        print("more stats")
                    }
                }
            }
        }
    }
}

struct DashboardAccountTransactionList_Previews: PreviewProvider {
    static var previews: some View {
        DashboardAccountTransactionList(store: TransactionStore())
    }
}

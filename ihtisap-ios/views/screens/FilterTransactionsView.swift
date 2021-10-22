//
//  FilterTransactionsView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 22.10.2021.
//

import SwiftUI

struct FilterTransactionsView: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var accountStore: AccountStore
    @StateObject var vm = FilterTransactionViewModel()
    
    var body: some View {
        Group {
            if vm.result.count == 0 {
                AppLoading()
                    .onAppear {
                        fetch()
                    }
            } else {
                List {
                    Section {
                        ForEach(vm.result) { item in
                            Text(item.title)
                        }
                    }
                }
            }
        }
        .navigationTitle("Filter Transactions")
    }
    
    func fetch() {
        guard let token = userStore.authToken else {
            return
        }
        
        guard let accountID = accountStore.selectedAccount?.id else {
            return
        }
        
        Task {
            await vm.fetchFilteredTransactions(token: token, accountID: accountID)
        }
    }
}

struct FilterTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterTransactionsView()
            .environmentObject(UserStore.mockData())
            .environmentObject(AccountStore())
    }
}

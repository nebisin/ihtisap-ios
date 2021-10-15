//
//  DashboardAccount.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct DashboardAccount: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var accountStore: AccountStore
    
    @StateObject var transactionStore = TransactionStore()
    
    @State private var selectedAccount = 0
    @State private var sheetPresented = false
    
    var body: some View {
        DashboardAccountTransactionList(store: transactionStore)
            .onAppear(perform: {
                guard let token = userStore.authToken else {
                    return
                }
                
                guard let accountID = accountStore.selectedAccount?.id else {
                    return
                }
                
                if !transactionStore.lastTransactions.isEmpty {
                    return
                }

                Task {
                    await transactionStore.fetchLastTransactions(token: token, accountID: accountID)
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    DashboardAccountPicker(selectedAccount: $selectedAccount, accounts: accountStore.allAccounts)
                        .onChange(of: selectedAccount) { newValue in
                            changeAccount()
                        }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title3)
                            .frame(width: 42, height: 42)
                            .foregroundColor(.brandPrimary)
                    }
                }
            }
            .sheet(isPresented: $sheetPresented) {
                CreateTransactionView(tsStore: transactionStore)
            }
    }
    
    func changeAccount() {
        accountStore.selectedAccount = accountStore.allAccounts.first(where: { account in
            return account.id == selectedAccount
        })
        
        guard let token = userStore.authToken else {
            return
        }
        
        guard let accountID = accountStore.selectedAccount?.id else {
            return
        }
        
        Task {
            await transactionStore.fetchLastTransactions(token: token, accountID: accountID)
        }
    }
}

struct DashboardAccount_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashboardAccount()
                .environmentObject(AccountStore())
                .environmentObject(UserStore.mockData())
        }
    }
}

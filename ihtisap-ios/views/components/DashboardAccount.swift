//
//  DashboardAccount.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct DashboardAccount: View {
    @EnvironmentObject var accountStore: AccountStore
    
    @State private var selectedAccount = 0
    
    var body: some View {
        Text("Dashboard yes account view")
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
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title3)
                            .frame(width: 42, height: 42)
                            .foregroundColor(.brandPrimary)
                    }
                }
            }
    }
    
    func changeAccount() {
        accountStore.selectedAccount = accountStore.allAccounts.first(where: { account in
            return account.id == selectedAccount
        })

    }
}

struct DashboardAccount_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashboardAccount()
                .environmentObject(AccountStore())
        }
    }
}

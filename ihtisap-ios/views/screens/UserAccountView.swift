//
//  UserAccountView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct UserAccountView: View {
    @EnvironmentObject var accountStore: AccountStore
    @State var isSheetPresented = false
    
    var body: some View {
        List {
            Section {
                ForEach(accountStore.allAccounts) { account in
                    NavigationLink {
                        
                    } label: {
                        Text(account.title)
                    }
                    
                }
            } footer: {
                Button {
                    isSheetPresented.toggle()
                } label: {
                    AppButtonPrimary(label: "Create new account", isLoading: false)
                }
            }
        }
        .sheet(isPresented: $isSheetPresented, content: {
            CreateAccountView()
        })
        .navigationTitle("All accounts")
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
    }
}

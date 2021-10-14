//
//  CreateAccount.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var accountStore: AccountStore
    
    @StateObject var vm = CreateAccountViewModel()
    @State var balanceText: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                VStack (alignment: .leading) {
                    TextField("Title", text: $vm.createAccountRequest.title)
                    
                    if let error = vm.validationError?.errors["title"] {
                        Text(error)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                }
                
                TextField("Description", text: $vm.createAccountRequest.description)
                Picker("Currency", selection: $vm.createAccountRequest.currency) {
                    ForEach(Currency.allCases) { currency in
                        Text(currency.rawValue)
                            .tag(currency)
                    }
                }
                TextField("Initial Balance", text: $balanceText)
                    .keyboardType(.decimalPad)
                    .onChange(of: balanceText) { newValue in
                        guard let value = Double(newValue) else {
                            vm.createAccountRequest.initialBalance = 0
                            return
                        }
                        vm.createAccountRequest.initialBalance = value
                    }
                
                Button("Create Account") {
                    Task {
                        guard let token = userStore.authToken else {
                            return
                        }
                        
                        let account = await vm.handleSubmit(token: token)
                        
                        guard let account = account else {
                            return
                        }
                        
                        accountStore.allAccounts.append(account)
                        accountStore.selectedAccount = account
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(vm.isLoading)
            }
            .navigationTitle("Create account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

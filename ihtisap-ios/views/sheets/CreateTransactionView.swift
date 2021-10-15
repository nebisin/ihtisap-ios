//
//  CreateTransaction.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct CreateTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var accountStore: AccountStore
    @ObservedObject var tsStore: TransactionStore
    @StateObject var vm = CreateTransactionViewModel()
    @State var amountText: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Transaction Type", selection: $vm.createTransactionRequest.type) {
                    Text("Income")
                        .tag(TransactionType.income)
                    Text("Expense")
                        .tag(TransactionType.expense)
                }
                .pickerStyle(.segmented)
                
                VStack (alignment: .leading) {
                    TextField("Title", text: $vm.createTransactionRequest.title)
                    
                    if let error = vm.validationError?.errors["title"], !error.isEmpty {
                        Text(error)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                }
                
                TextField("Description", text: $vm.createTransactionRequest.description)
                
                VStack (alignment: .leading) {
                    TextField("Amount", text: $amountText)
                        .keyboardType(.decimalPad)
                        .onChange(of: amountText) { newValue in
                            guard let value = Double(newValue) else {
                                vm.createTransactionRequest.amount = 0
                                return
                            }
                            vm.createTransactionRequest.amount = value
                        }
                    
                    if let error = vm.validationError?.errors["amount"], !error.isEmpty {
                        Text(error)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                }
                
                
                DatePicker("Payday", selection: $vm.createTransactionRequest.payday, displayedComponents: [.date])
                    .datePickerStyle(.automatic)
                
                Button("Create Transaction") {
                    Task {
                        guard let token = userStore.authToken else {
                            return
                        }
                        
                        guard let accountID = accountStore.selectedAccount?.id else {
                            return
                        }
                        
                        let ts = await vm.handleSubmit(token: token, accountID: accountID)
                        
                        guard let ts = ts else {
                            return
                        }
                        
                        tsStore.lastTransactions.insert(ts, at: 0)
                        
                        let index = accountStore.allAccounts.firstIndex { account in
                            account.id == accountStore.selectedAccount!.id
                        }
                        
                        if ts.type == .expense {
                            accountStore.selectedAccount!.totalExpense += ts.amount
                            accountStore.allAccounts[index!].totalExpense += ts.amount
                        } else {
                            accountStore.selectedAccount!.totalIncome += ts.amount
                            accountStore.allAccounts[index!].totalIncome += ts.amount
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(vm.isLoading)
            }
            .navigationTitle("Create transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTransactionView(tsStore: TransactionStore())
    }
}

//
//  TransactionStore.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import Foundation

class TransactionStore: ObservableObject {
    @Published var isLoading = false
    @Published var lastTransactions: [Transaction] = []
    @Published var errorMessage: String? = nil
    
    func fetchLastTransactions(token: String, accountID: Int) async -> Void {
        isLoading = true
                
        let (data, error) = await TransactionAPIService.shared.listTransactions(authToken: token, accountID: accountID)
        
        if let error = error {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            return
        }
                
        guard let data = data else {
            print("no data")
            DispatchQueue.main.async {
                self.errorMessage = "something went wrong"
                self.isLoading = false
            }
            return
        }
        
        print(data)
        
        DispatchQueue.main.async {
            self.lastTransactions = data.transactions
            self.isLoading = false
            self.errorMessage = nil
        }

    }
}

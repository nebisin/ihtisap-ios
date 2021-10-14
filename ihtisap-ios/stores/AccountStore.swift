//
//  AccountStore.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import Foundation

class AccountStore: ObservableObject {
    @Published var isLoading = false
    @Published var allAccounts: [Account] = []
    @Published var selectedAccount: Account? = nil
    @Published var errorMessage: String? = nil
    
    func fetchAccounts(token: String) async -> Void {
        isLoading = true
        
        let (data, error) = await AccountAPIService.shared.listAccounts(authToken: token)
        
        if let error = error {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            return
        }
        
        guard let data = data else {
            DispatchQueue.main.async {
                self.errorMessage = "something went wrong"
                self.isLoading = false
            }
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = nil
            self.allAccounts = data.accounts
            if !data.accounts.isEmpty {
                self.selectedAccount = self.allAccounts[0]
            }
        }
    }
}

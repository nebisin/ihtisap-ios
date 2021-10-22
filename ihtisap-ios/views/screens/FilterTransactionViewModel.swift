//
//  FilterTransactionViewModel.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 22.10.2021.
//

import Foundation

class FilterTransactionViewModel: ObservableObject {
    @Published var result: [Transaction] = []
    @Published var filterMethod: String = "-id"
    @Published var currentPage: Int = 1
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchFilteredTransactions(token: String, accountID: Int) async -> Void {
        isLoading = true
                
        let (data, error) = await TransactionAPIService.shared.listTransactions(authToken: token, accountID: accountID, sort: filterMethod)
        
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
            self.result = data.transactions
            self.isLoading = false
            self.errorMessage = nil
            self.currentPage = 2
        }
    }
    
    func addFilteredTransactions(token: String, accountID: Int) async -> Void {
        isLoading = true
                
        let (data, error) = await TransactionAPIService.shared.listTransactions(authToken: token, accountID: accountID, page: currentPage, sort: filterMethod)
        
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
            self.result.append(contentsOf: data.transactions)
            self.isLoading = false
            self.errorMessage = nil
            self.currentPage += 1
        }
    }
}

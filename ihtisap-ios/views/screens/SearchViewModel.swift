//
//  SearchViewModel.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 16.10.2021.
//

import Foundation

class SearchTabViewModel: ObservableObject {
    @Published var result: [Transaction] = []
    @Published var isLoading = false
    
    func searchTransaction(token: String, term: String = "") async -> APIError? {
        self.isLoading = true
        
        let (data, error) = await TransactionAPIService.shared.searchTransactions(authToken: token, term: term)
        if let error = error {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return error
        }
        
        guard let data = data else {
            return .unableToComplete
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.result = data.transactions
        }

        return nil
        
    }
    
    
    
}

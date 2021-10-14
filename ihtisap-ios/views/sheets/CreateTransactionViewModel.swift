//
//  CreateTransactionViewModel.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 15.10.2021.
//

import Foundation

class CreateTransactionViewModel: ObservableObject {
    @Published var createTransactionRequest = CreateTransactionRequest(accountID: 0, type: .expense, title: "", description: "", tags: [], amount: 0, payday: .now)
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var validationError: ValidationErrorResponse? = nil
    
    func handleSubmit(token: String, accountID: Int) async -> Transaction? {
        isLoading = true
        
        if !validate() {
            isLoading = false
            return nil
        }
        
        createTransactionRequest.accountID = accountID
        
        let (data, error) = await TransactionAPIService.shared.createTransaction(authToken: token, payload: createTransactionRequest)
        
        if let error = error {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
            
            return nil
        }
        
        guard let data = data else {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = "something went wrong"
            }
            
            return nil
        }

        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = nil
        }
        
        return data.transaction
    }
    
    func validate() -> Bool {
        var titleError = ""
        var amountError = ""
        
        if createTransactionRequest.title.isEmpty {
            titleError = "title is required"
        } else if createTransactionRequest.title.count < 3 {
            titleError = "title must be at least 3 characters"
        } else {
            titleError = ""
        }
        
        if createTransactionRequest.amount <= 0 {
            amountError = "amount must be greater than 0"
        } else {
            amountError = ""
        }
        
        if !titleError.isEmpty || !amountError.isEmpty {
            validationError = ValidationErrorResponse(errors: [
                "title": titleError,
                "amount": amountError
            ])
            return false
        }
        
        validationError = nil
        
        return true
    }
}

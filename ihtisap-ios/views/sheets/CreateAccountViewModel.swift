//
//  CreateAccountViewModel.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import Foundation

class CreateAccountViewModel: ObservableObject {
    @Published var createAccountRequest = CreateAccountRequest(title: "", description: "", currency: .USD, initialBalance: 0)
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var validationError: ValidationErrorResponse? = nil
    
    func handleSubmit(token: String) async -> Account? {
        isLoading = true
        
        if !validate() {
            isLoading = false
            return nil
        }
                
        let (data, error) = await AccountAPIService.shared.createAccount(authToken: token, payload: createAccountRequest)
        
        if let error = error {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            
            return nil
        }
        
        guard let data = data else {
            DispatchQueue.main.async {
                self.errorMessage = "something went wrong"
                self.isLoading = false
            }
            
            return nil
        }
        
        DispatchQueue.main.async {
            self.errorMessage = nil
            self.isLoading = false
        }

        return data.account
    }
    
    func validate() -> Bool {
        var titleError = ""
        
        if createAccountRequest.title.isEmpty {
            titleError = "title is required"
        } else if createAccountRequest.title.count < 3 {
            titleError = "title must be at least 3 characters"
        } else {
            titleError = ""
        }
        
        if !titleError.isEmpty {
            validationError = ValidationErrorResponse(errors: [
                "title": titleError,
            ])
            return false
        }
        
        validationError = nil
        
        return true
    }
}

//
//  AuthLoginViewModel.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

class AuthLoginViewModel: ObservableObject {
    @Published var loginRequest = LoginRequest(email: "", password: "")
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var validationError: ValidationErrorResponse? = nil
    
    func handleSubmit() async -> AuthToken? {
        isLoading = true
        
        guard validate() else {
            isLoading = false
            return nil
        }
        
        let (data, error) = await UserAPIService.shared.login(payload: loginRequest)
        
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
            self.isLoading = false
            self.errorMessage = nil
            self.validationError = nil
        }
        
        return data
    }
    
    func validate() -> Bool {
        var emailError: String = ""
        var passwordError: String = ""
        
        if loginRequest.email.isEmpty {
            emailError = "email is required"
        } else if !loginRequest.email.isValidEmail {
            emailError = "not valid email"
        } else {
            emailError = ""
        }
        
        if loginRequest.password.isEmpty {
            passwordError = "password is required"
        } else if loginRequest.password.count < 8 {
            passwordError = "password must contain at least 8 characters"
        } else {
            passwordError = ""
        }
        
        if emailError.isEmpty && passwordError.isEmpty {
            validationError = nil
            return true
        }
        
        validationError = ValidationErrorResponse(errors: [
            "email": emailError,
            "password": passwordError
        ])
        
        return false
    }
}

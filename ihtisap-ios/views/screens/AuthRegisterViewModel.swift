//
//  AuthRegisterViewModel.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import Foundation

class AuthRegisterViewModel: ObservableObject {
    @Published var registerRequest = RegisterRequest(name: "", email: "", password: "")
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var validationError: ValidationErrorResponse? = nil
    
    func handleSubmit() async -> AuthToken? {
        isLoading = true
        
        guard validate() else {
            isLoading = false
            return nil
        }
        
        let (registerData, registerError) = await UserAPIService.shared.register(payload: registerRequest)
        
        if let error = registerError {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            return nil
        }
        
        guard let _ = registerData else {
            DispatchQueue.main.async {
                self.errorMessage = "something went wrong"
                self.isLoading = false
            }
            return nil
        }
        
        let loginRequest = LoginRequest(email: registerRequest.email, password: registerRequest.password)
        
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
        var nameError: String = ""
        var emailError: String = ""
        var passwordError: String = ""
        
        if registerRequest.name.isEmpty {
            nameError = "name is required"
        } else if registerRequest.name.count < 3 {
            nameError = "name must contain at least 3 characters"
        } else {
            nameError = ""
        }
        
        if registerRequest.email.isEmpty {
            emailError = "email is required"
        } else if !registerRequest.email.isValidEmail {
            emailError = "you must enter a valid email"
        } else {
            emailError = ""
        }
        
        if registerRequest.password.isEmpty {
            passwordError = "password is required"
        } else if registerRequest.password.count < 8 {
            passwordError = "password must contain at least 8 characters"
        } else {
            passwordError = ""
        }
        
        if emailError.isEmpty && passwordError.isEmpty && nameError.isEmpty {
            validationError = nil
            return true
        }
        
        validationError = ValidationErrorResponse(errors: [
            "name": nameError,
            "email": emailError,
            "password": passwordError
        ])
        
        return false
    }
}

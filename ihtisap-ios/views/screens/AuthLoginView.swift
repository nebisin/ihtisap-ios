//
//  AuthLoginView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct AuthLoginView: View {
    @Binding var selectedView: String
    
    @StateObject var vm = AuthLoginViewModel()
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading) {
                Text("Sign in to your account")
                    .font(.title)
                    .padding(.bottom, 5)
                HStack {
                    Text("Don't have an account?")
                    
                    Button {
                        withAnimation {
                            selectedView = "Register"
                        }
                    } label: {
                        Text("Register instead")
                            .foregroundColor(.brandPrimary)
                    }

                }
                .font(.footnote)
                
                if let error = vm.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("Email")
                if let error = vm.validationError?.errors["email"] {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                TextField("johndoe@example.com", text: $vm.loginRequest.email)
                    .textFieldStyle(AppTextFieldBase())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.vertical, 10)
            
            VStack (alignment: .leading) {
                Text("Password")
                if let error = vm.validationError?.errors["password"] {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                SecureField("your password", text: $vm.loginRequest.password)
                    .textFieldStyle(AppTextFieldBase())
            }
            .padding(.vertical, 10)
            
            Button {
                Task {
                    let tokenResponse = await vm.handleSubmit()
                    guard let token = tokenResponse?.authenticationToken else {
                        return
                    }
                    
                    print(token)
                }
            } label: {
                AppButtonPrimary(label: "log in")
                    .padding(.top)
            }
        }
        .padding()
    }
}

struct AuthLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthLoginView(selectedView: .constant("Login"))
    }
}

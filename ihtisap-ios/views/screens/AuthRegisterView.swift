//
//  AuthRegisterView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct AuthRegisterView: View {
    @Binding var selectedView: String
    
    @StateObject var vm = AuthRegisterViewModel()
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading) {
                Text("Create new account")
                    .font(.title)
                    .padding(.bottom, 5)
                HStack {
                    Text("Already have an account?")
                    
                    Button {
                        withAnimation {
                            selectedView = "Login"
                        }
                    } label: {
                        Text("Login instead")
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
                Text("Name")
                if let error = vm.validationError?.errors["name"] {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                TextField("John Doe", text: $vm.registerRequest.name)
                    .textFieldStyle(AppTextFieldBase())
                    .disableAutocorrection(true)
            }
            .padding(.vertical, 10)
            
            VStack (alignment: .leading) {
                Text("Email")
                if let error = vm.validationError?.errors["email"] {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                TextField("johndoe@example.com", text: $vm.registerRequest.email)
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
                SecureField("your password", text: $vm.registerRequest.password)
                    .textFieldStyle(AppTextFieldBase())
            }
            .padding(.vertical, 10)
            
            Button {
                Task {
                    let tokenResponse = await vm.handleSubmit()
                    guard let token = tokenResponse?.authenticationToken else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        userStore.authToken = token
                    }
                    
                    await userStore.auth(token: token)
                }
            } label: {
                AppButtonPrimary(label: "register", isLoading: vm.isLoading)
                    .padding(.top)
            }
            .disabled(vm.isLoading)
            
        }
        .padding()
    }
}

struct AuthRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        AuthRegisterView(selectedView: .constant("Register"))
    }
}

//
//  AuthRegisterView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct AuthRegisterView: View {
    @Binding var selectedView: String

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    
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
            }
            .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("Name")
                TextField("John Doe", text: $name)
                    .textFieldStyle(AppTextFieldBase())
            }
            .padding(.vertical, 10)
            
            VStack (alignment: .leading) {
                Text("Email")
                TextField("johndoe@example.com", text: $email)
                    .textFieldStyle(AppTextFieldBase())
            }
            .padding(.vertical, 10)
            
            VStack (alignment: .leading) {
                Text("Password")
                TextField("your password", text: $password)
                    .textFieldStyle(AppTextFieldBase())
            }
            .padding(.vertical, 10)
            
            AppButtonPrimary(label: "register")
                .padding(.top)
        }
        .padding()
    }
}

struct AuthRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        AuthRegisterView(selectedView: .constant("Register"))
    }
}

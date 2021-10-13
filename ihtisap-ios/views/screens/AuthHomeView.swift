//
//  AuthHomeView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct AuthHomeView: View {
    @Binding var selectedView: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Advanced income and expense tracker")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            Text("with shared accounts, subscriptions, reminders and more...")
                .font(.footnote)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                withAnimation {
                    selectedView = "Register"
                }
            } label: {
                AppButtonPrimary(label: "create free account")
            }
            
            Text("or")
                .font(.subheadline)
            
            Button {
                withAnimation {
                    selectedView = "Login"
                }
            } label: {
                AppButtonSecondary(label: "sign in")
            }
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct AuthHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHomeView(selectedView: .constant("Home"))
    }
}

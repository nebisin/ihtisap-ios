//
//  UserView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        
                    } label: {
                        Label(userStore.user!.name, systemImage: "person")
                    }
                    
                    NavigationLink {
                        UserAccountView()
                    }label: {
                        Label("My accounts", systemImage: "wallet.pass")
                    }
                }
                
                Section {
                    Button {
                        userStore.logout()
                    } label: {
                        Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("User")
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(UserStore.mockData())
    }
}

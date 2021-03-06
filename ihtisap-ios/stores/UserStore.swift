//
//  UserStore.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

class UserStore: ObservableObject {
    @Published var isLoading = false
    @AppStorage("token") var authToken: String?
    @Published var user: User? = nil
    
    init() {
        Task {
            await auth()
        }
    }
    
    init(user: User) {
        self.user = user
        self.authToken = "12345"
    }
    
    func auth() async -> Void {
        guard let token = authToken else {
            return
        }

        if let _ = user {
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let payload = AuthToken(authenticationToken: token)
        
        let (data, error) = await UserAPIService.shared.auth(payload: payload)
        
        if let error = error {
            print(error)
            print(error.description)
            // TODO: Add proper error handling
            
            DispatchQueue.main.async {
                self.authToken = nil
                self.isLoading = false
            }
        }
        
        guard let data = data else {
            return
        }
        
        DispatchQueue.main.async {
            self.user = data.user
            self.isLoading = false
        }
        
        return
    }
    
    func logout() {
        authToken = nil
    }
    
    static func mockData() -> UserStore {
        return UserStore(user: User(id: 1, name: "deneme", email: "deneme@deneme.com", isActivated: true, createdAt: .now, version: 1))
    }
}

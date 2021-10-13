//
//  ContentView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userStore = UserStore()
    
    var body: some View {
        Group {
            if userStore.isLoading {
                AppLoading()
            } else if userStore.user == nil || userStore.authToken == nil {
                AuthView()
            } else {
                TabView()
            }
        }
        .onAppear(perform: {
            guard let token = userStore.authToken else {
                return
            }
            
            Task {
                await userStore.auth(token: token)
            }
        })
        .environmentObject(userStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

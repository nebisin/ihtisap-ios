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
            } else if userStore.authToken == nil {
                TheAuthView()
            } else {
                TheTabView()
            }
        }
        .onChange(of: userStore.authToken, perform: { newValue in
            Task {
                await userStore.auth()
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

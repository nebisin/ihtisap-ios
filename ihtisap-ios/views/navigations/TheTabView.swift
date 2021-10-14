//
//  TabView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct TheTabView: View {
    @StateObject var accountStore = AccountStore()
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            UserView()
                .tabItem {
                    Image(systemName: "person")
                    Text("User")
                }
        }
        .environmentObject(accountStore)
        .onAppear(perform: {
            guard let token = userStore.authToken else {
                return
            }
            Task {
                await accountStore.fetchAccounts(token: token)
            }
        })
    }
}

struct TheTabView_Previews: PreviewProvider {
    static var previews: some View {
        TheTabView()
            .environmentObject(UserStore.mockData())
    }
}

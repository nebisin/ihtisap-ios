//
//  DashboardView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var accountStore: AccountStore
    
    var body: some View {
        NavigationView {
            if accountStore.isLoading {
                AppLoading()
            } else if !accountStore.allAccounts.isEmpty {
                DashboardAccount()
            } else {
                DashboardNoAccount()
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(AccountStore())
    }
}

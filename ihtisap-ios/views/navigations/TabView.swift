//
//  TabView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject var userStore: UserStore
    var body: some View {
        VStack {
            Text("Tab View")
            Button("Log out") {
                userStore.logout()
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}

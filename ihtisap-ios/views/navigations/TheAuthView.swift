//
//  AuthView.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct TheAuthView: View {
    @State var selectedView = "Home"
    
    var body: some View {
        ZStack {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
            
            if selectedView == "Home" {
                AuthHomeView(selectedView: $selectedView)
            } else if selectedView == "Login" {
                AuthLoginView(selectedView: $selectedView)
            } else {
                AuthRegisterView(selectedView: $selectedView)
            }
        }
    }
}

struct TheAuthView_Previews: PreviewProvider {
    static var previews: some View {
        TheAuthView()
    }
}

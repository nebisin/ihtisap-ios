//
//  DashboardNoAccount.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 14.10.2021.
//

import SwiftUI

struct DashboardNoAccount: View {
    @State var isSheetPresented = false
    
    var body: some View {
        VStack {
            Text("You have no account.")
            Button("Create an account") {
                isSheetPresented.toggle()
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            CreateAccountView()
        }
    }
}

struct DashboardNoAccount_Previews: PreviewProvider {
    static var previews: some View {
        DashboardNoAccount()
    }
}

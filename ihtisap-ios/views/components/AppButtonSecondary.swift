//
//  AppButtonSecondary.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct AppButtonSecondary: View {
    var label: String
    
    var body: some View {
        Text(label)
            .bold()
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .foregroundColor(.brandPrimary)
            .background(Color.brandPrimary.opacity(0.1))
            .cornerRadius(10)
    }
}

struct AppButtonSecondary_Previews: PreviewProvider {
    static var previews: some View {
        AppButtonSecondary(label: "sign in")
            .previewLayout(.sizeThatFits)
    }
}

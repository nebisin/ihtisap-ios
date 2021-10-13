//
//  AppButtonPrimary.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct AppButtonPrimary: View {
    var label: String
    var isLoading: Bool = false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                Text(label)
                    .bold()
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color.brandPrimary)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct AppButtonPrimary_Previews: PreviewProvider {
    static var previews: some View {
        AppButtonPrimary(label: "create free account", isLoading: false)
            .previewLayout(.sizeThatFits)
    }
}

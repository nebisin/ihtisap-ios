//
//  AppTextFieldBase.swift
//  ihtisap-ios
//
//  Created by Salim Bozok on 13.10.2021.
//

import SwiftUI

struct AppTextFieldBase: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

struct AppTextFieldBase_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextField("email", text: .constant(""))
                .textFieldStyle(AppTextFieldBase())
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

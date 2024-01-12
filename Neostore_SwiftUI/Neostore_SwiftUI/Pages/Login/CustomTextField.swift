//
//  CustomTextFieldView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white)
            }
            TextField("", text: $text)
        }
    }
}

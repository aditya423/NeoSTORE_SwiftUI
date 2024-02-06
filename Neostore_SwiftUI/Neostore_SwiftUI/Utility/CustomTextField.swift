//
//  CustomTextFieldView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    
    var isImage: Bool
    var image: String
    var placeholder: String
    var isSecureTextField: Bool = false
    
    var body: some View {
        HStack {
            if isImage{
                Image(image)
                    .padding(.leading, 15)
                    .padding([.top, .bottom], 10)
                    .foregroundColor(.white)
            }
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white)
                }
                if isSecureTextField{
                    SecureField("", text: $text)
                        .textContentType(.oneTimeCode)
                } else{
                    TextField("", text: $text)
                }
            }
            .font(.system(size: 20))
            .padding(.leading, 10)
            .padding([.top, .bottom], 10)
            .fontWeight(.medium)
            .foregroundColor(.white)
        }
    }
}

//
//  CustomTextFieldView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import SwiftUI
//MARK: - CustomTextField
struct CustomTextField: View {
    //State Variables
    @Binding var text: String
    
    var isImage: Bool
    var image: String
    var placeholder: String
    var isSecureTextField: Bool = false
    
    //Body
    var body: some View {
        HStack {
            //Check for Image
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
                // Check for Password TextField
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
            .font(.footnote.weight(.medium))
            .foregroundColor(.white)
        }
    }
}

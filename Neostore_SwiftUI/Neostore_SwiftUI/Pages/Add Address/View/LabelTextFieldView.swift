//
//  LabelTextFieldView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 31/01/24.
//

import Foundation
import SwiftUI

struct LabelTextFieldView: View {
    
    // VARIABLES
    var textFieldPlaceHolder: String
    var textString: String
    @Binding var textFieldString: String
    
    // VIEW
    var body: some View {
        VStack{
            HStack{
                Text(textString)
                Spacer()
            }
            .padding([.horizontal,.top])
            
            HStack{
                TextField(textFieldPlaceHolder, text: $textFieldString)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white)
                    )
                    .font(.system(size: 15))
            }
            .padding(.horizontal)
        }
    }
}

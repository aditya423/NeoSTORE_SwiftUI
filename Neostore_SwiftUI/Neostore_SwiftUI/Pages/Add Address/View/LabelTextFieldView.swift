//
//  LabelTextFieldView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 31/01/24.
//

import Foundation
import SwiftUI

struct LabelTextFieldView: View {
    
    @Binding var textFieldString: String
    
    var textFieldPlaceHolder: String
    var textString: String
    
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
                    .background(.white)
            }
            .padding(.horizontal)
        }
    }
}

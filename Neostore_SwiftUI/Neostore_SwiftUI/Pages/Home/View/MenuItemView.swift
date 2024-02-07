//
//  MenuItemView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct MenuItemView: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .aspectRatio(contentMode: .fill)
                Spacer().frame(width: 15)
                Text(title)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .listRowBackground(Color.black)
    }
}

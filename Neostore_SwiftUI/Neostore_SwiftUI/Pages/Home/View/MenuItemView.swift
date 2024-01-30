//
//  MenuItemView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct MenuItemView: View {
    var menuImage: Image
    var menuData: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                menuImage
                    .resizable()
                    .frame(width: 25, height: 25)
                    .aspectRatio(contentMode: .fill)
                Spacer().frame(width: 15)
                Text(menuData)
                    .foregroundColor(.white)
            }
        }
        .listRowBackground(Color.black)
    }
}

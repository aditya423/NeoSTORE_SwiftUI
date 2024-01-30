//
//  FirstMenuItemView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct FirstMenuItemView: View {
    var menuImage: Image
    var menuData: String
    var viewModel = SideBarViewModel()
    
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
                Spacer()
                Text(SideBarViewModel.total_carts ?? "")
                    .frame(width: 25, height: 25)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
            }
        }
        .listRowBackground(Color.black)
    }
}

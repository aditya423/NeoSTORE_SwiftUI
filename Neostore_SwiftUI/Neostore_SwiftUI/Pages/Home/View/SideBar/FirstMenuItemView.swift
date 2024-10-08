//
//  FirstMenuItemView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct FirstMenuItemView: View {
    
    // VARIABLES
    var imageName: String
    var title: String
    @ObservedObject var viewModel: SideBarViewModel
    
    // VIEW
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
                Text(CommonViewModel.shared.total_carts ?? "")
                    .frame(width: 25, height: 25)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
            }
        }
        .listRowBackground(Color.black)
    }
}

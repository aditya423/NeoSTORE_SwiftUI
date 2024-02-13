//
//  ProfileView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct ProfileView: View {
    
    // VARIABLES
    @ObservedObject var viewModel: SideBarViewModel
    
    // VIEW
    var body: some View {
        VStack(alignment: .center) {
            if let image = loadImage(imgName: ImageNames.profileImage.rawValue) {
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .padding(.bottom, 10)
            } else {
                Image("")
                    .background(AppColors.grayColor)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .padding(.bottom, 10)
            }

            Text("\(CommonViewModel.shared.user_data?.first_name ?? "") \(CommonViewModel.shared.user_data?.last_name ?? "")")
                .bold()
                .font(.title2)
                .foregroundColor(.white)
            Text(verbatim: "\(CommonViewModel.shared.user_data?.email ?? "")")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color.black)
        .padding(.bottom, 20)
    }
}

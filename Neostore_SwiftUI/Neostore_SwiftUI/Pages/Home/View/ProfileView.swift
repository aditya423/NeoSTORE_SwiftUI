//
//  ProfileView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI
//MARK: - ProfileView
struct ProfileView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Image(ImageNames.profileImage.rawValue)
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
            Text("\(SideBarViewModel.user_data?.first_name ?? "") \(SideBarViewModel.user_data?.last_name ?? "")")
                .bold()
                .font(.title2)
                .foregroundColor(.white)
            Text(verbatim: "\(SideBarViewModel.user_data?.email ?? "")")        //verbatim because used @
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color.black)
        .padding(.bottom, 20)
    }
}
// preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

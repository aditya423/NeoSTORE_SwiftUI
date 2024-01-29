//
//  SideBarView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import SwiftUI

struct SideBarView: View {
    
    @Binding var isSidebarVisible: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    var viewModel = SideBarViewModel()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ZStack(alignment: .top) {
                    Color.black.edgesIgnoringSafeArea(.all)
                    List {
                        ForEach(0..<viewModel.menuData.count+1) { i in
                            if i == 0 {
                                ProfileView()
                            } else if i == 1 {
                                FirstMenuItemView(menuImage: Image(viewModel.menuImages[i-1]), menuData: viewModel.menuData[i-1])
                            } else {
                                MenuItemView(menuImage: Image(viewModel.menuImages[i-1]), menuData: viewModel.menuData[i-1])
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .frame(width: sideBarWidth)
                .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
                .animation(.default, value: isSidebarVisible)
                Spacer()
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("profile_image")
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
            Text("Aditya Ghadge")
                .bold()
                .font(.title2)
                .foregroundColor(.white)
            Text(verbatim: "adityasghadge@gmail.com")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color.black)
        .padding(.bottom, 20)
    }
}

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
                Text(String(viewModel.numberOfItemsInCart))
                    .frame(width: 25, height: 25)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
            }
        }
        .listRowBackground(Color.black)
    }
}

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


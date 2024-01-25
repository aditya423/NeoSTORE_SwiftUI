//
//  HomeView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isSidebarOpened = false
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        // main content
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppColors.primaryColor)
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationBarBackButtonHidden()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                withAnimation {
                                    isSidebarOpened.toggle()
                                }
                            } label: {
                                Image(systemName: isSidebarOpened ? ImageNames.backArrow.rawValue : ImageNames.threeLines.rawValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Text("NeoSTORE")
                                .bold()
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    .toolbarBackground(
                        AppColors.primaryColor,
                        for: .navigationBar
                    )
                }
                .background(.red)
                .onTapGesture {
                    isSidebarOpened = false
                }
            }
            .offset(x: isSidebarOpened ? sideBarWidth : 0)
            .padding(.top, isSidebarOpened ? 20 : 0)
            .padding(.bottom, isSidebarOpened ? 40 : 0)
            .background(Color.black)
            
            SideBarView(isSidebarVisible: $isSidebarOpened)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

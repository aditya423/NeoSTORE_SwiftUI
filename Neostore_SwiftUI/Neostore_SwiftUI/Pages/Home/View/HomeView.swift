//
//  HomeView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isSidebarOpened = false
    @State private var selection = 0
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    var viewModel = HomeViewModel()
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.darkGray
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        TabView(selection: $selection) {
                            ForEach(0..<viewModel.productsImages.count) { index in
                                Image(viewModel.productsImages[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .tag(index)
                                    .onTapGesture {
                                        withAnimation {
                                            isSidebarOpened = false
                                        }
                                    }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.3)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .navigationBarTitleDisplayMode(.inline)
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
                        Color.red,
                        for: .navigationBar
                    )
                }
                .background(.red)
                .onTapGesture {
                    withAnimation {
                        isSidebarOpened = false
                    }
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

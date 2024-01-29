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
    var viewModel = HomeViewModel()
    var screenWidth = UIScreen.main.bounds.width
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    
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
                        
                        ScrollView(.vertical) {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 20),
                                GridItem(.flexible(), spacing: 20)
                            ], spacing: 20) {
                                ForEach(0..<viewModel.furnitureData.count, id: \.self) { index in
                                    if let data = viewModel.furnitureData[index] {
                                        let title = data["name"] as? String ?? ""
                                        let titlePosition = data["lblPosition"] as? Position
                                        let imgName = data["imgName"] as? String ?? ""
                                        let imgPosition = data["imgPosition"] as? Position ?? Position.topLeft
                                        ZStack {
                                            VStack {
                                                switch titlePosition {
                                                case .topLeft:
                                                    Text(title)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                                        .padding([.top, .leading], 15)
                                                        .font(.title3)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                case .topRight:
                                                    Text(title)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                                        .padding([.top, .trailing], 15)
                                                        .font(.title3)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                case .bottomLeft:
                                                    Text(title)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                                        .padding([.bottom, .leading], 15)
                                                        .font(.title3)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                case .bottomRight:
                                                    Text(title)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                                        .padding([.bottom, .trailing], 15)
                                                        .font(.title3)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                default:
                                                    Text("")
                                                }
                                            }
                                            VStack {
                                                switch imgPosition {
                                                case .topLeft:
                                                    Image(imgName)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                                        .padding([.top, .leading], 15)
                                                case .topRight:
                                                    Image(imgName)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                                        .padding(.top, -10)
                                                        .padding(.trailing, 15)
                                                case .bottomLeft:
                                                    Image(imgName)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                                        .padding([.bottom, .leading], 15)
                                                case .bottomRight:
                                                    Image(imgName)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                                        .padding(.bottom, 10)
                                                        .padding(.trailing, 0)
                                                }
                                            }
                                        }
                                        .frame(width: (screenWidth/2)-30, height: (screenWidth/2)-30)
                                        .background(.red)
                                    }
                                }
                            }
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 20)
                        }
                    }
                    .frame(width: .infinity, height: UIScreen.main.bounds.height*0.9)
                    .background(Color.white)
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

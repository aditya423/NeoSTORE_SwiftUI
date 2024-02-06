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
    @State private var navigationId = 0
    var viewModel = HomeViewModel()
    var screenWidth = UIScreen.main.bounds.width
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.darkGray
    }
    
    var body: some View {
        
        ZStack {
            // HOME
            NavigationView {
                VStack(spacing: 0) {
                    // RED NAVIGATION
                    VStack(spacing: 0) {
                        Color.red.edgesIgnoringSafeArea(.all)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                    }
                    ScrollView {
                        // IMAGES CV
                        TabView(selection: $selection) {
                            ForEach(0..<viewModel.productsImages.count, id: \.self) { index in
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
                        .onReceive(timer) { _ in
                            withAnimation {
                                if selection < viewModel.productsImages.count-1 {
                                    selection += 1
                                } else {
                                    selection = 0
                                }
                            }
                        }
                        // BLOCKS CV
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
                                        NavigationLink(destination: ProductListView(categoryId: index)) {
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
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 20)
                        }
                    }
                }
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
                                .font(.title3)
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
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: MyCartView()) {
                            Image(systemName: ImageNames.systemCart.rawValue)
                                .font(.title3)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                .toolbarBackground(
                    Color.red,
                    for: .navigationBar
                )
                .onTapGesture {
                    withAnimation {
                        isSidebarOpened = false
                    }
                }
            }
            .navigationBarHidden(true)
            .offset(x: isSidebarOpened ? sideBarWidth : 0)
            .scrollDisabled(isSidebarOpened ? true : false)
            
            // SIDEBAR
            ZStack {
                if isSidebarOpened {
                    Color.black.opacity(0.001)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isSidebarOpened = false
                            }
                        }
                }
                SideBarView(isSidebarVisible: $isSidebarOpened)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("popToHome"))) { output in
            navigationId += 1
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

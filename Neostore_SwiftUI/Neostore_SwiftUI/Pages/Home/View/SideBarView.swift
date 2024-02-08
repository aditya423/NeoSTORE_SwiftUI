//
//  SideBarView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import SwiftUI
//MARK: - SideBarView
struct SideBarView: View {
    //State Objects
    @Binding var isSidebarVisible: Bool
    @StateObject var viewModel = SideBarViewModel()
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                // To Show Loader
                    if viewModel.vmVars.isLoading {
                        ZStack {
                            Color.black.edgesIgnoringSafeArea(.all)
                            VStack {
                                LoaderView(bgColor: .white, tintColor: nil)
                            }
                        }
                        .frame(width: sideBarWidth)
                        .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
                        .animation(.default, value: isSidebarVisible)
                        Spacer()
                    } else {
                        ZStack(alignment: .top) {
                            Color.black.edgesIgnoringSafeArea(.all)
                            List {
                                ForEach(0..<viewModel.menuData.count+1, id: \.self) { indexRow in
                                    let imageName = viewModel.menuData[indexRow]?["imageName"] ?? ""
                                    let title = viewModel.menuData[indexRow]?["title"] ?? ""
                                    switch indexRow {
                                    case 0:
                                        // Profile Image and Name
                                        ProfileView()
                                    case 1:
                                        // Cart
                                        ZStack {
                                            FirstMenuItemView(imageName: imageName, title: title, viewModel: viewModel)
                                            NavigationLink(destination: MyCartView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 2...5:
                                        // Furniture Items
                                        ZStack {
                                            if let categoryId = viewModel.menuData[indexRow]?["categoryId"], let intCategoryId = Int(categoryId) {
                                                let newCategoryId = intCategoryId - 1
                                                MenuItemView(imageName: imageName, title: title)
                                                NavigationLink(destination: ProductListView(categoryId: newCategoryId)) {
                                                    EmptyView()
                                                }
                                                .opacity(0)
                                            }
                                        }
                                        .listRowBackground(Color.black)
                                    case 6:
                                        // My Account
                                        ZStack {
                                            MenuItemView(imageName: imageName, title: title)
                                            NavigationLink(destination: MyAccountView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 7:
                                        // Store Locator
                                        ZStack {
                                            MenuItemView(imageName: imageName, title: title)
                                            NavigationLink(destination: StoreLocatorView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 8:
                                        // My Orders
                                        ZStack {
                                            MenuItemView(imageName: imageName, title: title)
                                            NavigationLink(destination: OrderListView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 9:
                                        // For Logout
                                        MenuItemView(imageName: imageName, title: title)
                                            .onTapGesture {
                                                UserDefaults.standard.setLoggedIn(value: false)
                                                UserDefaults.standard.setUserToken(value: nil)
                                                NotificationCenter.default.post(name: Notification.Name(NotificationNames.popToLogin.rawValue), object: nil)
                                            }
                                    default:
                                        EmptyView()
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
        .onChange(of: isSidebarVisible) { isVisible in
            if isVisible {
                viewModel.vmVars.isLoading = true
                viewModel.getAccountDetails()
            }
        }
        .onAppear {
            viewModel.vmVars.isLoading = false
        }
        .alert(viewModel.vmVars.alertMessage, isPresented: $viewModel.vmVars.showAlert) {
            Button(ButtonTitles.ok.rawValue, role: .cancel) {
                viewModel.vmVars.isLoading = false
            }
        }
    }
}

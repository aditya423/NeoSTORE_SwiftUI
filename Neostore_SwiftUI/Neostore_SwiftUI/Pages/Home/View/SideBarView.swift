//
//  SideBarView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import SwiftUI

struct SideBarView: View {
    
    @Binding var isSidebarVisible: Bool
    @StateObject var viewModel = SideBarViewModel()
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                //Group {
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
                                        ProfileView()
                                    case 1:
                                        ZStack {
                                            FirstMenuItemView(imageName: imageName, title: title, viewModel: viewModel)
                                            NavigationLink(destination: MyCartView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 2...5:
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
                                        ZStack {
                                            MenuItemView(imageName: imageName, title: title)
                                            NavigationLink(destination: MyAccountView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 7:
                                        ZStack {
                                            MenuItemView(imageName: imageName, title: title)
                                            NavigationLink(destination: StoreLocatorView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 8:
                                        ZStack {
                                            MenuItemView(imageName: imageName, title: title)
                                            NavigationLink(destination: OrderListView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
                                    case 9:
                                        // LOGOUT
                                        ZStack {
                                            MenuItemView(imageName: imageName, title: title)
                                            NavigationLink(destination: MyAccountView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
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
                //}
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
            Button("OK", role: .cancel) {
                viewModel.vmVars.isLoading = false
            }
        }
    }
}

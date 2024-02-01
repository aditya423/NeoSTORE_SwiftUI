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
                Group {
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
                                ForEach(0..<viewModel.menuData.count+1) { i in
                                    if i == 0 {
                                        ProfileView()
                                    } else if i == 1 {
                                        ZStack {
                                            FirstMenuItemView(menuImage: Image(viewModel.menuImages[i-1]), menuData: viewModel.menuData[i-1])
                                            NavigationLink(destination: MyCartView()) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        }
                                        .listRowBackground(Color.black)
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
        .onChange(of: isSidebarVisible) { isVisible in
            if isVisible {
                viewModel.vmVars.isLoading = true
                viewModel.getAccountDetails()
            }
        }
        .alert(viewModel.vmVars.alertMessage, isPresented: $viewModel.vmVars.showAlert) {
            Button("OK", role: .cancel) {
                viewModel.vmVars.isLoading = false
            }
        }
    }
}

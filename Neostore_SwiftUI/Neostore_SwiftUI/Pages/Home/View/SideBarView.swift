//
//  SideBarView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import SwiftUI

struct SideBarView: View {
    
    @Binding var isSidebarVisible: Bool
    @ObservedObject var viewModel = SideBarViewModel()
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    
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
        .onChange(of: isSidebarVisible) { isVisible in
            if isVisible {
                viewModel.getAccountDetails()
            }
        }
        .alert(isPresented: $viewModel.vmVars.showAlert) {
            Alert(title: Text(AlertMessages.errorMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
        }
    }
}

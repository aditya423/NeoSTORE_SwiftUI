//
//  AddressListView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 05/02/24.
//

import SwiftUI

struct AddressListView: View {
    
    @StateObject var viewModel = AddressListViewModel()
    @State var checked = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            Color.red.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            VStack {
                if viewModel.address.count != 0 {
                    HStack {
                        Group {
                            if checked {
                                ZStack{
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 25, height: 25)
                                    Circle()
                                        .fill(AppColors.grayColor)
                                        .frame(width: 15, height: 15)
                                }
                                .onTapGesture {
                                    self.checked = false
                                }
                            } else {
                                ZStack{
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 25, height: 25)
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 15, height: 15)
                                }
                                .onTapGesture {
                                    self.checked = true
                                }
                            }
                        }
                        
                        Text(UserDefaults.standard.string(forKey: Keys.fullAddress.rawValue) ?? "")
                            .padding(.horizontal, 10)
                        
                        Image(ImageNames.cancel.rawValue)
                            .onTapGesture {
                                viewModel.removeAddress()
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: ImageNames.backArrow.rawValue)
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Address List")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddAddressView()) {
                        Image(systemName: ImageNames.plusImage.rawValue)
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
            .onAppear {
                viewModel.setAddress()
            }
        }
    }
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        AddressListView()
    }
}

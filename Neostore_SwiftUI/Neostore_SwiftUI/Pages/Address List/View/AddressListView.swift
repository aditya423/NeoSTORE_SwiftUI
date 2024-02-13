//
//  AddressListView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 05/02/24.
//

import SwiftUI

struct AddressListView: View {
    
    // VARIABLES
    @StateObject var placeOrderViewModel = MyOrdersViewModel()
    @StateObject var viewModel = AddressListViewModel()
    @State private var checked = true
    @State private var isButtonEnabled = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // VIEW
    var body: some View {
        VStack(spacing: 0) {
            Color.red.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            ZStack {
                if placeOrderViewModel.placeOrderVars.isLoading {
                    LoaderView(bgColor: AppColors.grayColor, tintColor: Color.red)
                } else {
                    VStack {
                        if let fulladdress = viewModel.address {
                            if fulladdress.count != 0 {
                                if let address = fulladdress[0] {
                                    HStack {
                                        Text("Shipping Address")
                                        Spacer()
                                    }
                                    .padding([.top, .horizontal], 20)
                                    
                                    HStack {
                                        Group {
                                            if checked {
                                                ZStack{
                                                    Circle()
                                                        .fill(Color.gray)
                                                        .frame(width: 20, height: 20)
                                                    Circle()
                                                        .fill(AppColors.grayColor)
                                                        .frame(width: 12, height: 12)
                                                }
                                                .onTapGesture {
                                                    self.checked = false
                                                    self.isButtonEnabled = false
                                                }
                                            } else {
                                                ZStack{
                                                    Circle()
                                                        .fill(Color.gray)
                                                        .frame(width: 20, height: 20)
                                                    Circle()
                                                        .fill(Color.white)
                                                        .frame(width: 12, height: 12)
                                                }
                                                .onTapGesture {
                                                    self.checked = true
                                                    self.isButtonEnabled = true
                                                }
                                            }
                                        }
                                        .padding(.leading, 20)
                                        
                                        Text(address)
                                            .padding(.horizontal, 10)
                                        
                                        Spacer()
                                        
                                        Image(ImageNames.cancel.rawValue)
                                            .onTapGesture {
                                                viewModel.removeAddress()
                                            }
                                            .padding(.trailing, 20)
                                    }
                                    .padding(.top, 15)
                                    
                                    HStack {
                                        NavigationLink(destination: OrderListView(), isActive: $placeOrderViewModel.placeOrderVars.isNavigating) {
                                            Button {
                                                placeOrderViewModel.placeOrderVars.isLoading = true
                                                placeOrderViewModel.placeOrder(address: address)
                                            } label: {
                                                ButtonTextView(text: "PLACE ORDER", fgColor: self.isButtonEnabled ? Color.white : AppColors.grayColor)
                                                    .background(.red)
                                                    .cornerRadius(5)
                                            }
                                        }
                                        .disabled(isButtonEnabled ? false : true)
                                        .padding(.top, 15)
                                        .padding(.horizontal, 20)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                    .alert(isPresented: $placeOrderViewModel.placeOrderVars.showAlert) {
                        Alert(title: Text(AlertMessages.errorMsg.rawValue), message: Text(placeOrderViewModel.placeOrderVars.alertMessage))
                    }
                    .onAppear {
                        viewModel.setAddress()
                    }
                }
            }
        }
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
                NavigationLink(destination: AddAddressView(addressListVM: viewModel)) {
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
    }
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        AddressListView()
    }
}

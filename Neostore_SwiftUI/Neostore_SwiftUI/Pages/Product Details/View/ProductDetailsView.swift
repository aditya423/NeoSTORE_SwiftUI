//
//  ProductDetailsView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @ObservedObject var viewModel = ProductDetailsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var productId: Int?
    
    init(productId: Int?) {
        self.productId = productId
        viewModel.getProductDetails(productId: String(productId ?? 0))
    }
    
    var body: some View {
        VStack(spacing: 0){
            Color.red.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 1)
            VStack{
                if viewModel.dataReceived {
                    VStack{
                        ScrollView {
                            VStack{
                                ProductDetailTitleView(productDetails: viewModel.productDetails)
                                ProductDetailDescriptionView(productDetails: viewModel.productDetails, productImages: viewModel.productDetails?.product_images ?? [])
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                        HStack(spacing:20){
                            Button {
                                
                            } label: {
                                Text("BUY NOW")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                                    .bold()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.red)
                                    .cornerRadius(5)
                                    .padding(.leading,10)
                                    .alert(isPresented: $viewModel.vmVars.showAlert) {
                                        Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
                                    }
                            }
                            Button {
                                
                            } label: {
                                Text("RATE")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                                    .bold()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.gray)
                                    .cornerRadius(5)
                                    .padding(.trailing,10)
                                    .alert(isPresented: $viewModel.vmVars.showAlert) {
                                        Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
                                    }
                            }
                        }
                        .padding(20)
                        .background(.white)
                    }
                    
                } else {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarBackButtonHidden()
            .onAppear{
                viewModel.getProductDetails(productId: String(productId ?? 0))
            }
            .toolbar(content: {
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
                    Text(viewModel.productDetails?.name ?? "Product Details")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            })
            .toolbarBackground(
                AppColors.primaryColor,
                for: .navigationBar
            )
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(productId: 2)
    }
}

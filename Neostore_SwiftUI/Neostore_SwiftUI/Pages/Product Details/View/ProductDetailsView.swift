//
//  ProductDetailsView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI

struct ProductDetailsView: View {
    
    // VARIABLES
    var productId: Int?
    @ObservedObject var viewModel = ProductDetailsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(productId: Int?) {
        self.productId = productId
        viewModel.getProductDetails(productId: String(productId ?? 0))
    }
    
    // VIEW
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Color.red.edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                VStack{
                    //Till Data not Received show Loader
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
                                    viewModel.isBuyNowPresented = true
                                } label: {
                                    ButtonTextView(text: ButtonTitles.buyNow.rawValue, fgColor: Color.white)
                                        .background(.red)
                                        .cornerRadius(5)
                                        .padding(.leading,10)
                                        .alert(isPresented: $viewModel.vmVars.showAlert) {
                                            Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
                                        }
                                }
                                
                                Button {
                                    viewModel.isRateNowPresented = true
                                } label: {
                                    ButtonTextView(text: ButtonTitles.rate.rawValue, fgColor: Color.white)
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
                        .applyShimmer(if: !viewModel.dataReceived)
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
                        Text(viewModel.productDetails?.name ?? Constants.productDetails.rawValue)
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                })
                .toolbarBackground(
                    AppColors.primaryColor,
                    for: .navigationBar
                )
            }
            if viewModel.isRateNowPresented{
                RateNowPopupView(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.2))
            }
            if viewModel.isBuyNowPresented{
                BuyNowPopupView(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.2))
            }
        }
        .alert(isPresented: $viewModel.vmVars.showAlert) {
            Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
        }
    }
}
//preview
struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(productId: 2)
    }
}

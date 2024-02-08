//
//  ProductDetailsView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI
//MARK: - ProductDetailsView
struct ProductDetailsView: View {
    //State Objects
    @State var isBuyNowPresented: Bool = false
    @State var isRateNowPresented: Bool = false
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
                //Till Data not Received show Loader
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
                                isBuyNowPresented = true
                            } label: {
                                Text(ButtonTitles.buyNow.rawValue)
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
                            .fullScreenCover(isPresented: $isBuyNowPresented, content: {
                                BuyNowPopupView(viewModel: viewModel)
                            })
                            
                            Button {
                                isRateNowPresented = true
                            } label: {
                                Text(ButtonTitles.rate.rawValue)
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
                            .fullScreenCover(isPresented: $isRateNowPresented, content: {
                                RateNowPopupView(viewModel: viewModel)
                            })
                        }
                        .padding(20)
                        .background(.white)
                    }
                    
                } else {
                    LoaderView(bgColor: AppColors.grayColor, tintColor: Color.red)
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
    }
}
//preview
struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(productId: 2)
    }
}

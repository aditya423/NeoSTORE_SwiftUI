//
//  BuyNowPopupView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 08/02/24.
//

import SwiftUI

struct BuyNowPopupView: View {
    
    // VARIABLES
    var productDetails: ProductDetails?
    @State var quantity:String = ""
    @StateObject var viewModel: ProductDetailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // VIEW
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Spacer()
                    Button {
                        viewModel.isBuyNowPresented = false
                    } label: {
                        Image(ImageNames.cancel.rawValue)
                            .padding([.horizontal,.top])
                    }
                }
                Text("\(viewModel.productDetails?.name ?? "")")
                    .font(.title2)
                    .padding()
                AsyncImage(url: URL(string: viewModel.productDetails?.product_images?[0].image ?? ""))
                { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                        Image("")
                            .resizable()
                            .scaledToFit()
                    default:
                        ProgressView()
                    }
                }
                .frame(maxWidth: 200,maxHeight: 160)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(AppColors.grayColor, lineWidth: 1)
                )
                .cornerRadius(5)
                .padding()
                
                Text(Constants.enterQty.rawValue)
                    .padding([.top,.horizontal])
                TextField("", text: $quantity)
                    .frame(maxWidth: 80,maxHeight: 40)
                    .border(AppColors.grayColor,width: 1)
                    .keyboardType(.numberPad)
                Button {
                    viewModel.addToCart(quantity: quantity)
                } label: {
                    ButtonTextView(text: ButtonTitles.submit.rawValue, fgColor: Color.white)
                        .background(.red)
                        .cornerRadius(5)
                        .padding()
                        .padding(.horizontal,40)
                        
                }
            }
            .background(.white)
            .cornerRadius(10)
            .padding()
            .padding(.vertical,50)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.clear)
    }
}

//preview
struct BuyNowPopupView_Previews: PreviewProvider {
    static var previews: some View {
        BuyNowPopupView(viewModel: ProductDetailsViewModel())
    }
}

//
//  RateNowPopupView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 08/02/24.
//

import SwiftUI

struct RateNowPopupView: View {
    
    // VARIABLES
    var productDetails: ProductDetails?
    @State var rating: Int = 0
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
                
                HStack{
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { i in
                                Image( i <= rating ? ImageNames.filledStar.rawValue : ImageNames.emptyStar.rawValue)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        if i == 1 && rating == 1{
                                            rating = 0
                                        } else {
                                            rating = i
                                        }
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity,maxHeight: 15)
                        .padding()
                }
                Button {
                    viewModel.rateProduct(rating: String(rating))
                } label: {
                    ButtonTextView(text: ButtonTitles.rateNow.rawValue, fgColor: Color.white)
                        .background(.red)
                        .cornerRadius(5)
                        .padding()
                        .padding(.horizontal,40)
                        .background(Color.clear)
                }
            }
            .background(.white)
            .cornerRadius(10)
            .padding()
            .padding(.vertical,50)
        }
    }
}

struct RateNowPopupView_Previews: PreviewProvider {
    static var previews: some View {
        RateNowPopupView(viewModel: ProductDetailsViewModel())
    }
}

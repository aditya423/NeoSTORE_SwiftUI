//
//  BuyNowPopupView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 08/02/24.
//

import SwiftUI

struct BuyNowPopupView: View {
    
    var productDetails: ProductDetails?
    
    var body: some View {
        VStack{
            VStack{
                Text("\(productDetails?.name ?? "")")
                    .padding()
                AsyncImage(url: URL(string: productDetails?.product_images?[0].image ?? ""))
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
                Text("Enter Qty")
                
            }
            .background(.white)
            .padding()
            .padding(.vertical,50)
        }
        .background(.black.opacity(0.2))
    }
}

struct BuyNowPopupView_Previews: PreviewProvider {
    static var previews: some View {
        BuyNowPopupView()
    }
}

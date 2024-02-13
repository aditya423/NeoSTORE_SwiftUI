//
//  ProductDetailTitleView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 01/02/24.
//

import SwiftUI
//MARK: - ProductDetailTitleView
struct ProductDetailTitleView: View {
    
    var productDetails: ProductDetails? 
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                
                VStack(alignment:.leading){
                    Text(productDetails?.name ?? "")
                        .bold()
                        .font(.title)
                        .padding(.horizontal,2)
                    Text("Category: \(HomeViewModel.furnitureData[productDetails?.product_category_id ?? 0]?["name"] as? String ?? "")")
                        .font(.title3)
                        .padding(.horizontal,2)
                    
                    HStack(alignment:.bottom){
                        Text("\(productDetails?.producer ?? "")")
                            .fontWeight(.light)
                            .font(.subheadline)
                            .padding(.horizontal,2)
                        HStack{
                            Spacer()
                                .frame(maxWidth: .infinity)
                            HStack(spacing: 2) {
                                ForEach(0..<5, id: \.self) { i in
                                    Image( i < (productDetails?.rating ?? 0) ? "star_check" : "star_unchek")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }
                            }
                            .frame(maxWidth: .infinity,maxHeight: 15)
                            .padding(.bottom,5)
                        }
                        .padding(0)
                    }
                    .padding(0)
                }
            }
            .padding([.leading,.top,.bottom])
        }
        .background(.white)
    }
}
//preview
struct ProductDetailTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailTitleView()
    }
}

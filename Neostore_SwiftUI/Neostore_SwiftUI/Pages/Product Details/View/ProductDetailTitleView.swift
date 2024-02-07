//
//  ProductDetailTitleView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 01/02/24.
//

import SwiftUI

struct ProductDetailTitleView: View {
    
    var productDetails: ProductDetails? = ProductDetails(id: 2, product_category_id: 2, name: "Aditya", producer: "Ghadge", description: "venliooiljoib4; oiomixjoj4moijtoixoilt hbhxoij,oi4joixj4oithg oihxojoijoij4t ", cost: 50000, rating: 3, view_count: 3, created: "12345", modified: "2134", product_images: [])
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                
                VStack(alignment:.leading){
                    Text(productDetails?.name ?? "")
                        .fontWeight(.bold)
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
    }
}

struct ProductDetailTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailTitleView()
    }
}

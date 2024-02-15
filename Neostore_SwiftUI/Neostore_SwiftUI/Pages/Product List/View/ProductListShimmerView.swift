//
//  ProductListShimmerView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 13/02/24.
//

import SwiftUI

struct ProductListShimmerView: View {
    var body: some View {
            List{
                ForEach(0 ..< 10, id: \.self) { index in
                        ProductListCell(productData: ProductListDetails(id: 1, product_category_id: 1, name: "Product Details", producer: "Product Details", description: "This is the description of Product List details", cost: 5000, rating: 5, view_count: 5, created: "Product Details", modified: "Product Details", product_images: ""))
                    .listRowInsets(EdgeInsets(top: (index == 0 ? 20 : 0), leading: 10, bottom: 0, trailing: 0))
                    .padding(0)
                    Rectangle()
                        .frame(maxWidth: .infinity,maxHeight: 1)
                        .foregroundColor(AppColors.grayColor)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(0)
                }
                .listRowSeparator(.hidden)
            }
            .redacted(reason: .placeholder)
            .shimmering()
    }
}

struct ProductListShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListShimmerView()
    }
}

//
//  ProductDetailDescriptionView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 01/02/24.
//

import SwiftUI

struct ProductDetailDescriptionView: View {
    
    var productDetails: ProductDetails? = ProductDetails(id: 2, product_category_id: 2, name: "Aditya", producer: "Ghadge", description: "venliooiljoib4; oiomixjoj4moijtoixoilt hbhxoij,oi4joixj4oithg oihxojoijoij4t ", cost: 50000, rating: 3, view_count: 3, created: "12345", modified: "2134", product_images: [])
    var productImages: [ProductImages?] = []
    
    var body: some View {
        VStack{
            HStack{
                Text("\(productDetails?.cost ?? 0)")
                Spacer()
                Button {
                    
                } label: {
                    Image(ImageNames.share.rawValue)
                }
            }
            .padding()
            AsyncImage(url: URL(string: productImages[0]?.image ?? ""))
            { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(maxWidth: 150,maxHeight: 150,alignment: .center)
                case .failure(_):
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150,maxHeight: 150,alignment: .center)
                default:
                    ProgressView()
                }
            }
            .padding()
            
            ScrollView(.horizontal) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 20),
                    GridItem(.flexible(), spacing: 20)
                ], spacing: 20) {
                    ForEach(0..<productImages.count, id: \.self) { index in
                    }
                }
            }
            
        }
    }
}

struct ProductDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailDescriptionView()
    }
}

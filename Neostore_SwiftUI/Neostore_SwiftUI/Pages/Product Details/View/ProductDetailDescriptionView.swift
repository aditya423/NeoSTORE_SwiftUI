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
    @State var selectedImage = 0
    var isOutofStock: Bool = false
    var body: some View {
        VStack{
            HStack{
                Text("Rs: \(productDetails?.cost ?? 3)")
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding(.horizontal)
                Spacer()
                if isOutofStock{
                    Text("Out of Stock")
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding(.horizontal)
                }
                Button {
                    
                } label: {
                    Image(ImageNames.share.rawValue)
                        .padding(.horizontal)
                }
            }
            .padding()
            AsyncImage(url: URL(string: productImages[0]?.image ?? ""))
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
            .frame(maxWidth: 180,maxHeight: 180)
            .padding()
            .border(AppColors.grayColor,width: 1)
            .cornerRadius(5)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [
                    GridItem(.flexible(), spacing: 20)
                ], spacing: 20) {
                    ForEach(0..<productImages.count, id: \.self) { index in
                        AsyncImage(url: URL(string: productImages[index]?.image ?? ""))
                        { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure(_):
                                Image("")
                                    .resizable()
                                    .scaledToFit()
                            default:
                                ProgressView()
                            }
                        }
                        .frame(maxWidth: 80,maxHeight: 80,alignment: .center)
                        .onTapGesture {
                            selectedImage = index
                        }
                        .padding(.horizontal)
                        .padding(10)
                        .border((selectedImage == index ? .red:.black),width: 1)
                        .cornerRadius(5)
                        .padding(.bottom,20)
                        
                    }
                }
            }
            VStack(alignment: .leading){
                Text("Description")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.horizontal,2)
                Text("\(productDetails?.description ?? "")")
            }
            
        }
        .background(.white)
    }
}

struct ProductDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailDescriptionView()
    }
}

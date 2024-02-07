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
            AsyncImage(url: URL(string: productImages[selectedImage]?.image ?? ""))
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke((selectedImage == index ? .red:.black), lineWidth: 1)
                        )
                        .cornerRadius(5)
                        .padding(.bottom,10)
                        .padding(.leading,(index == 0 ? 20 : 0))
                    }
                }
            }
            Rectangle()
                .frame(maxWidth: .infinity,maxHeight: 1)
                .background(AppColors.grayColor)
                .opacity(0.2)
            VStack(alignment: .leading){
                Text("Description")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.horizontal,2)
                Text("\(productDetails?.description ?? "")")
                    .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .background(.white)
    }
}

struct ProductDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailDescriptionView()
    }
}

//
//  ProductDetailDescriptionView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 01/02/24.
//

import SwiftUI
//MARK: - ProductDetailDescriptionView
struct ProductDetailDescriptionView: View {
    
    var productDetails: ProductDetails? 
    var productImages: [ProductImages?] = []
    var isOutofStock: Bool = false
    
    //State Variables
    @State var selectedImage = 0
    
    var body: some View {
        VStack{
            HStack{
                Text("Rs: \(productDetails?.cost ?? 3)")
                    .foregroundColor(.red)
                    .bold()
                    .font(.title3)
                    .padding(.horizontal)
                Spacer()
                if isOutofStock{
                    Text(Constants.outOfStock.rawValue)
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
                                .stroke((selectedImage == index ? .red : .gray), lineWidth: (selectedImage == index ? 2 : 1))
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
                Text(Constants.description.rawValue)
                    .bold()
                    .font(.title)
                    .padding(.horizontal,2)
                Text("\(productDetails?.description ?? "")")
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .background(.white)
    }
}
//preview
struct ProductDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailDescriptionView()
    }
}

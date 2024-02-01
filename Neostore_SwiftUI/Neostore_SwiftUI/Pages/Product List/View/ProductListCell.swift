//
//  ProductListCell.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 31/01/24.
//

import SwiftUI

struct ProductListCell: View {
    
    var productData: ProductListDetails?
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: productData?.product_images ?? ""))
            { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(maxWidth: 80,maxHeight: 80,alignment: .center)
                case .failure(_):
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 80,maxHeight: 80,alignment: .center)
                default:
                    ProgressView()
                }
            }
            .padding(.trailing)
            
            VStack(alignment: .leading){
                Text(productData?.name ?? "")
                    .fontWeight(.bold)
                    .font(.headline)
                Text(productData?.producer ?? "")
                    .fontWeight(.light)
                    .font(.caption)
                ZStack{
                    HStack{
                        Text("Rs: \(productData?.cost ?? 3)")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .font(.title3)
                        Spacer()
                            .frame(maxWidth: .infinity)
                    }
                    HStack{
                        Spacer()
                            .frame(maxWidth: .infinity)
                        HStack(spacing: 2) {
                                ForEach(0..<5, id: \.self) { i in
                                    Image( i < (productData?.rating ?? 0) ? "star_check" : "star_unchek")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }
                            }
                            .frame(maxWidth: .infinity,maxHeight: 15)
                            .padding(0)
                    }
                }
            }
        }
        .padding(0)
    }
}

struct ProductListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductListCell()
    }
}

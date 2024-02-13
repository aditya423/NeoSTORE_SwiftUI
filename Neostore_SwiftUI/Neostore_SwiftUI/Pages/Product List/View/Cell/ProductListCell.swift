//
//  ProductListCell.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 31/01/24.
//

import SwiftUI

struct ProductListCell: View {
    
    // VARIABLES
    var productData: ProductListDetails?
    
    // VIEW
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: productData?.product_images ?? ""))
            { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                case .failure(_):
                    Image("")
                        .resizable()
                        .scaledToFill()
                default:
                    ProgressView()
                }
            }
            .frame(maxWidth: 80,maxHeight: 80,alignment: .center)
            .padding(.trailing)
            
            VStack(alignment: .leading){
                Text(productData?.name ?? "")
                    .bold()
                    .font(.headline)
                Text(productData?.producer ?? "")
                    .fontWeight(.light)
                    .font(.caption)
                ZStack{
                    HStack{
                        Text("Rs: \(productData?.cost ?? 3)")
                            .foregroundColor(.red)
                            .bold()
                            .font(.title3)
                        Spacer()
                            .frame(maxWidth: .infinity)
                    }
                    HStack{
                        Spacer()
                            .frame(maxWidth: .infinity)
                        HStack(spacing: 2) {
                                ForEach(0..<5, id: \.self) { i in
                                    Image( i < (productData?.rating ?? 0) ? ImageNames.filledStar.rawValue : ImageNames.emptyStar.rawValue)
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

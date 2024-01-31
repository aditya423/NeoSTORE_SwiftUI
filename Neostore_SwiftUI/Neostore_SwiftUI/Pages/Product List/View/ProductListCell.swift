//
//  ProductListCell.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 31/01/24.
//

import SwiftUI

struct ProductListCell: View {
    
    var productImg: String = "profile_image"
    var productName: String = "Stylish Morden Dining Table"
    var productCategory: String = "Aron Table Centre"
    var productPrice: String = "Rs: 27,390"
    var productRating: Int = 3
    
    var body: some View {
        HStack{
            Image(productImg)
                .resizable()
                .frame(maxWidth: 100,maxHeight: 100,alignment: .center)
                .padding(.leading)
            
            VStack(alignment: .leading){
                Text(productName)
                    .fontWeight(.bold)
                    .font(.headline)
                Text(productCategory)
                    .fontWeight(.light)
                    .font(.caption)
                HStack{
                    Text(productPrice)
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .font(.title3)
                    Spacer()
                    HStack(spacing: 2) {
                        ForEach(0...5, id: \.self) { i in
                            Image( i<productRating ? "star_check" : "star_unchek")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .frame(width: .infinity,height: 20)
                }
            }
            .padding()
        }
    }
}

struct ProductListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductListCell()
    }
}

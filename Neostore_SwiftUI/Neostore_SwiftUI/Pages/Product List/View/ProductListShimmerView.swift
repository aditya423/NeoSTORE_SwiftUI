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
                        ProductListCell()
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
    }
}

struct ProductListShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListShimmerView()
    }
}

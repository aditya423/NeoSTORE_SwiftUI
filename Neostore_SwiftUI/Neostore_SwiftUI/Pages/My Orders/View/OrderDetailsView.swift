//
//  OrderDetailsView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct OrderDetailsView: View {
    
    // VARIABLES
    @State private var selectedQuantity = 1
    @State private var editIndex = 0
    @Binding var orderId: Int?
    @StateObject var viewModel = MyOrdersViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // VIEW
    var body: some View {
        VStack(spacing: 0) {
            Color.red.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            ZStack {
                if viewModel.orderDetailsVars.isLoading {
                    LoaderView(bgColor: AppColors.grayColor, tintColor: Color.red)
                } else {
                    List {
                        if let productDetails = viewModel.orderDetailsVars.product_details {
                            ForEach(0..<productDetails.count, id: \.self) { indexRow in
                                VStack {
                                    HStack {
                                        AsyncImage(url: URL(string: productDetails[indexRow].prod_image ?? "")) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            case .failure(_):
                                                Image("")
                                                    .resizable()
                                                    .scaledToFill()
                                            default:
                                                ProgressView()
                                            }
                                        }
                                        .frame(width: 130, height: 85)
                                        .background(AppColors.grayColor)
                                        .padding(.leading, 20)
                                        
                                        VStack(alignment: .leading) {
                                            Text(productDetails[indexRow].prod_name ?? "")
                                            Text("(\(productDetails[indexRow].prod_cat_name ?? ""))")
                                                .foregroundColor(.gray)
                                                .padding(.bottom, 5)
                                            HStack {
                                                Text("QTY : \(productDetails[indexRow].quantity ?? 0)")
                                                Spacer()
                                                Text("₹\(productDetails[indexRow].total ?? 0)")
                                            }
                                        }
                                        .padding(.leading, 10)
                                        .padding(.trailing, 10)
                                        
                                        Spacer()
                                    }
                                    .padding(.vertical, 20)
                                    
                                    Spacer()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .background(AppColors.grayColor)
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                            }
                            
                            HStack {
                                Text("TOTAL")
                                Spacer()
                                Text("₹\(Int(viewModel.orderDetailsVars.order_details?.cost ?? 0))")
                            }
                            .padding(.vertical, 20)
                            .bold()
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: ImageNames.backArrow.rawValue)
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            ToolbarItem(placement: .principal) {
                Text("Order ID : \(orderId ?? 0)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .toolbarBackground(
            Color.red,
            for: .navigationBar
        )
        .onAppear {
            viewModel.orderDetailsVars.isLoading = true
            viewModel.getOrderDetails(id: orderId ?? 0)
        }
    }
}

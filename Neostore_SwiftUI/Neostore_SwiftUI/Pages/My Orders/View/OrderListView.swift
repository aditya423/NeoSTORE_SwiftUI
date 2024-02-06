//
//  OrderListView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct OrderListView: View {
    
    @StateObject var viewModel = OrderListViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            Color.red.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            ZStack {
                if viewModel.vmVars.isLoading {
                    LoaderView(bgColor: AppColors.grayColor, tintColor: Color.red)
                } else {
                    List {
                        if let orderList = viewModel.order_list {
                            ForEach(0..<(viewModel.order_list?.count ?? 0), id: \.self) { indexRow in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Order ID: \(orderList[indexRow].id ?? 0)")
                                            .padding(.bottom, 5)
                                        Text("Ordered Date: \(orderList[indexRow].created ?? "")")
                                    }
                                    .padding(.leading, 20)
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("₹\(Int(orderList[indexRow].cost ?? 0))")
                                    }
                                    .padding(.trailing, 20)
                                }
                                .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.white)
                            }
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
                        NotificationCenter.default.post(name: Notification.Name("popToHome"), object: nil)
                    }
            }
            ToolbarItem(placement: .principal) {
                Text("My Orders")
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
            viewModel.vmVars.isLoading = true
            viewModel.getOrderList()
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}

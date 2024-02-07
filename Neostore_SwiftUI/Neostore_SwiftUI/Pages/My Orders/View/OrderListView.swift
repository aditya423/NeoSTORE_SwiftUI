//
//  OrderListView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import SwiftUI

struct OrderListView: View {
    
    @State var orderId: Int?
    @State var isNavigating = false
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
                                VStack {
                                    ZStack {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("Order ID : \(orderList[indexRow].id ?? 0)")
                                                    .font(.system(size: 18))
                                                    .padding(.bottom, 5)
                                                Text("Ordered Date : \(orderList[indexRow].created ?? "")")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.gray)
                                            }
                                            .padding(.leading, 20)
                                            Spacer()
                                            VStack(alignment: .trailing) {
                                                Text("₹\(Int(orderList[indexRow].cost ?? 0))")
                                                    .font(.system(size: 20))
                                            }
                                            .padding(.trailing, 20)
                                        }
                                        .padding([.top, .bottom], 20)
                                    }
                                    .onTapGesture {
                                        orderId = orderList[indexRow].id ?? 0
                                        isNavigating = true
                                    }
                                    
                                    Spacer()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .background(AppColors.grayColor)
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                            }
                        }
                    }
                    
                    NavigationLink(destination: OrderDetailsView(orderId: $orderId), isActive: $isNavigating) {
                        EmptyView()
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

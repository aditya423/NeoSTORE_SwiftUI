//
//  MyOrdersViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 13/02/24.
//

import Foundation
import Combine

class MyOrdersViewModel: ObservableObject {
 
    @Published var orderListVars = OrderListVars()
    @Published var orderDetailsVars = OrderDetailsVars()
    @Published var placeOrderVars = PlaceOrderVars()
    @Published var order_list: [OrderList]? = [OrderList(id: 1, cost: 500, created: ""),OrderList(id: 1, cost: 500, created: ""),OrderList(id: 1, cost: 500, created: ""),OrderList(id: 1, cost: 500, created: "")]
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: GET ORDER LIST API CALL
    func getOrderList() {
        GetOrderService.getOrders()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.orderListVars.alertMessage = error.localizedDescription
                    self.orderListVars.showAlert = true
                }
            }, receiveValue: { (success, emptyData, invalidData) in
                if success != nil {
                    self.order_list = success?.data
                    self.orderListVars.isLoading = false
                } else if emptyData != nil {
                    self.orderListVars.isLoading = false
                    self.orderListVars.alertMessage = emptyData?.user_msg ?? AlertMessages.orderListEmptyMsg.rawValue
                    self.orderListVars.showAlert = true
                } else {
                    self.orderListVars.isLoading = false
                    self.orderListVars.alertMessage = invalidData?.user_msg ?? AlertMessages.invalidDataOrToken.rawValue
                    self.orderListVars.showAlert = true
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: GET ORDER DETAILS API CALL
    func getOrderDetails(id: Int) {
        GetOrderDetailsService.getOrderDetails(orderId: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.orderDetailsVars.alertMessage = error.localizedDescription
                    self.orderDetailsVars.showAlert = true
                }
            }, receiveValue: { (success, invalidData) in
                if success != nil {
                    self.orderDetailsVars.order_details = success?.data
                    self.orderDetailsVars.product_details = success?.data?.order_details
                    self.orderDetailsVars.isLoading = false
                } else {
                    self.orderDetailsVars.alertMessage = invalidData?.user_msg ?? AlertMessages.invalidDataOrToken.rawValue
                    self.orderDetailsVars.showAlert = true
                    self.orderDetailsVars.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: PLACE ORDER API CALL
    func placeOrder(address: String) {
        PlaceOrderService.placeOrder(address: address)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.placeOrderVars.alertMessage = error.localizedDescription
                    self.placeOrderVars.showAlert = true
                }
            }, receiveValue: { (success, invalidData, invalidToken, wrongMethod) in
                if success != nil {
                    self.placeOrderVars.isLoading = false
                    if let msg = success?.user_msg {
                        if msg == "Cart empty." {
                            self.placeOrderVars.isNavigating = false
                            self.placeOrderVars.alertMessage = success?.user_msg ?? ""
                            self.placeOrderVars.showAlert = true
                        } else {
                            self.placeOrderVars.isNavigating = true
                        }
                    }
                } else if invalidData != nil {
                    self.placeOrderVars.isLoading = false
                    self.placeOrderVars.alertMessage = invalidData?.user_msg ?? ""
                    self.placeOrderVars.showAlert = true
                } else if invalidToken != nil {
                    self.placeOrderVars.isLoading = false
                    self.placeOrderVars.alertMessage = invalidToken?.user_msg ?? ""
                    self.placeOrderVars.showAlert = true
                } else {
                    self.placeOrderVars.isLoading = false
                    self.placeOrderVars.alertMessage = wrongMethod?.user_msg ?? ""
                    self.placeOrderVars.showAlert = true
                }
            })
            .store(in: &cancellables)
    }
}

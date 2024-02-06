//
//  OrderListViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 06/02/24.
//

import Foundation
import Combine

struct OrderListVars {
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
}

class OrderListViewModel: ObservableObject {
    
    @Published var vmVars = OrderListVars()
    @Published var order_list: [OrderList]?
    private var cancellables = Set<AnyCancellable>()
    
    func getOrderList() {
        MyOrderService.getOrders()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success, emptyData, invalidData) in
                if success != nil {
                    self.order_list = success?.data
                    self.vmVars.isLoading = false 
                } else if emptyData != nil {
                    self.vmVars.isLoading = false
                    self.vmVars.alertMessage = emptyData?.user_msg ?? AlertMessages.orderListEmptyMsg.rawValue
                    self.vmVars.showAlert = true
                } else {
                    self.vmVars.isLoading = false
                    self.vmVars.alertMessage = invalidData?.user_msg ?? AlertMessages.invalidDataOrToken.rawValue
                    self.vmVars.showAlert = true
                }
            })
            .store(in: &cancellables)
    }
}

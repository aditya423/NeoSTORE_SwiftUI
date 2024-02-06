//
//  OrderDetailsViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 06/02/24.
//

import Foundation
import Combine

struct OrderDetailsVars {
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
}

class OrderDetailsViewModel {
    
    @Published var vmVars = OrderDetailsVars()
    @Published var order_details: OrderDetailsOverview?
    @Published var product_details: [OrderDetails]?
    private var cancellables = Set<AnyCancellable>()
    
    func getOrderDetails(id: Int) {
        MyOrderService.getOrderDetails(orderId: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success, invalidData) in
                if success != nil {
                    self.order_details = success?.data
                    self.product_details = success?.data?.order_details
                    self.vmVars.isLoading = false
                } else {
                    self.vmVars.alertMessage = invalidData?.user_msg ?? AlertMessages.invalidDataOrToken.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
}

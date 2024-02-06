//
//  PlaceOrderViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 06/02/24.
//

import Foundation
import Combine

struct PlaceOrderVars {
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
    var isNavigating = false
}

class PlaceOrderViewModel: ObservableObject {
    
    @Published var vmVars = PlaceOrderVars()
    private var cancellables = Set<AnyCancellable>()
    
    func placeOrder(address: String) {
        MyOrderService.placeOrder(address: address)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success, invalidData, invalidToken, wrongMethod) in
                if success != nil {
                    self.vmVars.isLoading = false
                    //self.vmVars.alertMessage = success?.user_msg ?? ""
                    //self.vmVars.showAlert = true
                    if let msg = success?.user_msg {
                        if msg == "Cart empty." {
                            self.vmVars.isNavigating = false
                            self.vmVars.alertMessage = success?.user_msg ?? ""
                            self.vmVars.showAlert = true
                        } else {
                            self.vmVars.isNavigating = true
                        }
                    }
                } else if invalidData != nil {
                    self.vmVars.isLoading = false
                    self.vmVars.alertMessage = invalidData?.user_msg ?? ""
                    self.vmVars.showAlert = true
                } else if invalidToken != nil {
                    self.vmVars.isLoading = false
                    self.vmVars.alertMessage = invalidToken?.user_msg ?? ""
                    self.vmVars.showAlert = true
                } else {
                    self.vmVars.isLoading = false
                    self.vmVars.alertMessage = wrongMethod?.user_msg ?? ""
                    self.vmVars.showAlert = true
                }
            })
            .store(in: &cancellables)
    }
}

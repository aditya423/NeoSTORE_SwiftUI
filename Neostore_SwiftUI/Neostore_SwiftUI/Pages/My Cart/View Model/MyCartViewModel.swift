//
//  MyCartViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 31/01/24.
//

import Foundation
import Combine

struct MyCartVariables {
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
}

class MyCartViewModel: ObservableObject {
    
    @Published var vmVars = MyCartVariables()
    var productList: [ListCartItemsData]? = []
    var total_items: Int = 0
    var total_price: Int = 0
    var pickerData = ["1", "2", "3", "4", "5", "6", "7", "8"]
    private var cancellables = Set<AnyCancellable>()
    
    func getCartItemsList() {
        ListCartItemsService.getCartItems()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success, cartEmpty, invalidToken, wrongMethod) in
                if success != nil {
                    self.productList = success?.data
                    self.total_items = success?.count ?? 0
                    self.total_price = Int(success?.total ?? 0)
                    self.vmVars.isLoading = false
                } else if cartEmpty != nil {
                    self.vmVars.alertMessage = cartEmpty?.user_msg ?? AlertMessages.emptyCartMsg.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                } else if invalidToken != nil {
                    self.vmVars.alertMessage = invalidToken?.user_msg ?? AlertMessages.invalidToken.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                } else if wrongMethod != nil {
                    self.vmVars.alertMessage = wrongMethod?.user_msg ?? AlertMessages.wrongMethod.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
}

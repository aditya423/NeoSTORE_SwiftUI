//
//  MyCartViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 31/01/24.
//

import Foundation
import Combine

class MyCartViewModel: ObservableObject {
    
    @Published var vmVars = MyCartVariables()
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
                    self.vmVars.productList = success?.data
                    self.vmVars.total_items = success?.count ?? 0
                    self.vmVars.total_price = Int(success?.total ?? 0)
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
    
    func deleteCartItem(id: Int) {
        DeleteCartItemService.deleteItemFromCart(id: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success, invalidId, invalidToken, wrongMethod) in
                if success != nil {
                    CommonViewModel.shared.total_carts = String(success?.total_carts ?? 0)
                    self.vmVars.total_items = success?.total_carts ?? 0
                    self.getCartItemsList()
                } else if invalidId != nil {
                    self.vmVars.alertMessage = invalidId?.user_msg ?? AlertMessages.invalidId.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                } else if invalidToken != nil {
                    self.vmVars.alertMessage = invalidToken?.user_msg ?? AlertMessages.invalidToken.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                } else {
                    self.vmVars.alertMessage = wrongMethod?.user_msg ?? AlertMessages.wrongMethod.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
    
    func editItemQuantity(id: Int, qty: Int) {
        EditCartItemService.editCartItemQuantity(id: id, qty: qty)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success, invalidId, invalidQty) in
                if success != nil {
                    self.vmVars.total_items = success?.total_carts ?? 0
                    self.getCartItemsList()
                } else if invalidId != nil {
                    self.vmVars.alertMessage = invalidId?.user_msg ?? AlertMessages.invalidId.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                } else {
                    self.vmVars.alertMessage = invalidQty?.user_msg ?? AlertMessages.invalidQuantity.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
}

//
//  SideBarViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import Foundation
import Combine

struct SideBarPublishedVars {
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
}

class SideBarViewModel: ObservableObject {
    
    static var user_data: UserDetails?
    var total_orders: String?
    private var cancellables = Set<AnyCancellable>()
    @Published var vmVars = SideBarPublishedVars()
    
    let menuData = ["My Cart", "Tables", "Sofas", "Chairs", "Cupboards", "My Account", "Store Locator", "My Orders", "Logout"]
    let menuImages = ["my-cart-icon", "table", "sofa_icon", "chair", "cupboard-icon", "username_icon", "storelocator_icon", "my-orders-icon", "logout_icon"]
    
    func getAccountDetails() {
        AccountDetailsService.getAccountDetails()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (accountDetails, invalidToken, error) in
                if accountDetails != nil {
                    SideBarViewModel.user_data = accountDetails?.data?.user_data
                    CommonViewModel.shared.total_carts = String(accountDetails?.data?.total_carts ?? 0)
                    self.total_orders = String(accountDetails?.data?.total_orders ?? 0)
                    self.vmVars.isLoading = false
                } else if invalidToken != nil {
                    self.vmVars.alertMessage = invalidToken?.user_msg ?? ""
                    self.vmVars.showAlert = true
                } else {
                    self.vmVars.alertMessage = error?.user_msg ?? error.debugDescription
                    self.vmVars.showAlert = true
                }
            })
            .store(in: &cancellables)
    }
}

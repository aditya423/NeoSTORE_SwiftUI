//
//  SideBarViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import Foundation
import Combine

class SideBarViewModel: ObservableObject {

    // VARIABLES
    var total_orders: String?
    private var cancellables = Set<AnyCancellable>()
    let menuData = [0: ["imageName":"", "title":"", "row":"0"],
                    1: ["imageName":"my-cart-icon", "title":"My Cart"],
                    2: ["imageName":"table", "title":"Tables", "categoryId":"1"],
                    3: ["imageName":"sofa_icon", "title":"Sofas", "categoryId":"2"],
                    4: ["imageName":"chair", "title":"Chairs", "categoryId":"3"],
                    5: ["imageName":"cupboard-icon", "title":"Cupboards", "categoryId":"4"],
                    6: ["imageName":"username_icon", "title":"My Account"],
                    7: ["imageName":"storelocator_icon", "title":"Store Locator"],
                    8: ["imageName":"my-orders-icon", "title":"My Orders"],
                    9: ["imageName":"logout_icon", "title":"Logout"]
    ]
    @Published var vmVars = SideBarPublishedVars()
    
    // API CALL
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
                    CommonViewModel.shared.user_data = accountDetails?.data?.user_data
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

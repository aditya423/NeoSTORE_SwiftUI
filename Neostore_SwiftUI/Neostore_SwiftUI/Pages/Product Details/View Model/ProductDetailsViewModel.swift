//
//  ProductDetailsViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 06/02/24.
//

import Foundation
import SwiftUI
import Combine
//MARK: - ProductDetailsViewModel
class ProductDetailsViewModel: ObservableObject{
    //Published Objects
    @Published var vmVars = NavPublishVars()
    @Published var dataReceived = false
    
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    var productDetails: ProductDetails?

    //APi Call
    func getProductDetails(productId: String){
        ProductDetailsService.getProductDetails(product_id: productId)
            .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                self.vmVars.alertMessage = error.localizedDescription
                                self.vmVars.showAlert = true
                            }
                        }, receiveValue: { (success, errorMsg) in
                            // On Success Set Data else Show Alert
                            if success != nil {
                                self.dataReceived = true
                                self.productDetails = success?.data
                            } else if errorMsg != nil {
                                self.vmVars.alertMessage = errorMsg?.user_msg ?? ""
                                self.vmVars.showAlert = true
                            }
                        })
                        .store(in: &cancellables)
    }
    
}

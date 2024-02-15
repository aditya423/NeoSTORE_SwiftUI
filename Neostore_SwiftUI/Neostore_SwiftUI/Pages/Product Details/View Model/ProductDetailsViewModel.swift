//
//  ProductDetailsViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 06/02/24.
//

import Foundation
import SwiftUI
import Combine

class ProductDetailsViewModel: ObservableObject{
    
    // VARIABLES
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    var productDetails: ProductDetails? = ProductDetails(id: 1, product_category_id: 1, name: "Product Details", producer: "Product Details", description: "This is the description of Product List details", cost: 5000, rating: 5, view_count: 5, created: "Product Details", modified: "Product Details", product_images: [ProductImages(id: 1, product_id: 1, image: "", created: "", modified: ""),ProductImages(id: 1, product_id: 1, image: "", created: "", modified: ""),ProductImages(id: 1, product_id: 1, image: "", created: "", modified: "")])
    @Published var dataReceived = false
    @Published var vmVars = NavPublishVars()
    @Published var isBuyNowPresented = false
    @Published var isRateNowPresented = false

    // API CALL
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
    
    //Add To Cart APi Call
    func addToCart(quantity: String){
        ProductDetailsService.addToCart(product_id:String(productDetails?.id ?? 0),quantity: quantity)
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
                                self.isBuyNowPresented = false
                                self.vmVars.alertMessage = success?.user_msg ?? ""
                                self.vmVars.showAlert = true
                            } else if errorMsg != nil {
                                self.vmVars.alertMessage = errorMsg?.user_msg ?? ""
                                self.vmVars.showAlert = true
                            }
                        })
                        .store(in: &cancellables)
    }
    
    //Rate Now APi Call
    func rateProduct(rating: String){
        ProductDetailsService.rateProduct(product_id:String(productDetails?.id ?? 0),rating: rating)
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
                                self.isRateNowPresented = false
                                self.vmVars.alertMessage = success?.user_msg ?? ""
                                self.vmVars.showAlert = true
                            } else if errorMsg != nil {
                                self.vmVars.alertMessage = errorMsg?.user_msg ?? ""
                                self.vmVars.showAlert = true
                            }
                        })
                        .store(in: &cancellables)
    }
}

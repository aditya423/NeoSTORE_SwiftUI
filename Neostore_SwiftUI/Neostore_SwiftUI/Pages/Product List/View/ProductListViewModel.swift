//
//  ProductListViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 01/02/24.
//

import Foundation
import SwiftUI
import Combine

class ProductListViewModel: ObservableObject{
    
    @Published var vmVars = NavPublishVars()
    @Published var dataReceived = false
    
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    var productList: [ProductListDetails] = []
    var filterProductList: [ProductListDetails] = []
    var page: Int = 1
    var limit: Int = 10

    func getProductList(categoryId: String){
        ProductListService.getProductList(categoryId: categoryId, page: page, limit: limit)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                self.vmVars.alertMessage = error.localizedDescription
                                self.vmVars.showAlert = true
                            }
                        }, receiveValue: { (success, error) in
                            if success != nil {
                                self.vmVars.isNavigating = true
                                self.dataReceived = true
                                self.productList.append(contentsOf: success?.data ?? [])
                                self.filterProductList = self.productList
                            } else if error != nil {
                                self.vmVars.isNavigating = false
                                self.vmVars.alertMessage = error.debugDescription
                                self.vmVars.showAlert = true
                            }
                        })
                        .store(in: &cancellables)
    }
    
    func filterProducts(text: String){
        if text != ""{
            filterProductList = productList.filter { $0.name?.lowercased().contains(text.lowercased()) ?? false}
        } else {
            filterProductList = productList
        }
        dataReceived = true
    }
}

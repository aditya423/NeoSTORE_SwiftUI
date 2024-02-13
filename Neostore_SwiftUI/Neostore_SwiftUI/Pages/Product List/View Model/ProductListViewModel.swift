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
    
    // VARIABLES
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    var productList: [ProductListDetails] = []
    var filterProductList: [ProductListDetails] = []
    var page: Int = 1
    var limit: Int = 10
    @Published var dataReceived = false
    @Published var vmVars = NavPublishVars()

    // API CALL
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
                            // On Success Set ProductList else Show Alert
                            if success != nil {
                                self.dataReceived = true
                                self.productList.append(contentsOf: success?.data ?? [])
                                self.filterProductList = self.productList
                            } else if error != nil {
                                self.vmVars.alertMessage = error.debugDescription
                                self.vmVars.showAlert = true
                            }
                        })
                        .store(in: &cancellables)
    }
    
    // SEARCH FILTER
    func filterProducts(text: String){
        if text != ""{
            filterProductList = productList.filter { $0.name?.lowercased().contains(text.lowercased()) ?? false}
        } else {
            filterProductList = productList
        }
        dataReceived = true
    }
}

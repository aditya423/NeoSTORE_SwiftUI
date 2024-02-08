//
//  ProductDetailService.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 06/02/24.
//

import Foundation
import Combine
//MARK: - ProductDetailsService
class ProductDetailsService{
    
    static  func getProductDetails(product_id: String) -> (AnyPublisher<(ProductDetailsResponse?, ProductDetailsInvalidCategory?), Error>) {
        
        let params = ["product_id": product_id] as [String: Any]
        //Call Common API
        return APIManager.sharedInstance.makeApiCall(serviceType: .getProductDetails(parameters: params))
            .tryMap { data in
                // Mapping Data into Model
                do {
                    let responseData = try JSONDecoder().decode(ProductDetailsResponse.self, from: data)
                    if responseData.status != 200 {
                        let responseData2 = try JSONDecoder().decode(ProductDetailsInvalidCategory.self, from: data)
                        return (nil, responseData2)
                    }
                    return (responseData, nil)
                }
                catch {
                        throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

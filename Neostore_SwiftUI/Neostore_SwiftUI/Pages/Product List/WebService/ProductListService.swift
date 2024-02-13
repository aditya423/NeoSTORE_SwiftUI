//
//  ProductListService.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 01/02/24.
//

import Foundation
import Combine

class ProductListService{
    
    static  func getProductList(categoryId: String, page: Int, limit: Int) -> (AnyPublisher<(ProductListResponse?, ProductListInvalidCategoryId?), Error>) {
        
        let params = ["product_category_id": categoryId, "page": page, "limit": limit] as [String: Any]
        return APIManager.sharedInstance.makeApiCall(serviceType: .getProductList(parameters: params))
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(ProductListResponse.self, from: data)
                    if responseData.status != 200 {
                        let responseData2 = try JSONDecoder().decode(ProductListInvalidCategoryId.self, from: data)
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

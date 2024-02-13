//
//  ProductListService.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 01/02/24.
//

import Foundation
import Combine
//MARK: - ProductListService
class ProductListService{
    
    static  func getProductList(categoryId: String, page: Int, limit: Int) -> (AnyPublisher<(ProductListResponse?, ProductListInvalidCategoryId?), Error>) {
        
        let params = ["product_category_id": categoryId, "page": page, "limit": limit] as [String: Any]
        //Call Common api Function
        return APIManager.sharedInstance.makeApiCall(serviceType: .getProductList(parameters: params))
            .tryMap { data in
                //Mapping Data into Model
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

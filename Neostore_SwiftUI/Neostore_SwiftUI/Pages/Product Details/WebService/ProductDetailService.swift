//
//  ProductDetailService.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 06/02/24.
//

import Foundation
import Combine

class ProductDetailsService{
    
    static  func getProductDetails(product_id: String) -> (AnyPublisher<(ProductDetailsResponse?, ProductDetailsInvalidCategory?), Error>) {
        
        let params = ["product_id": product_id] as [String: Any]
        return APIManager.sharedInstance.makeApiCall(serviceType: .getProductDetails(parameters: params))
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
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
    
    static  func addToCart(product_id: String,quantity:String) -> (AnyPublisher<(AddToCartSuccessResponse?, AddToCartInvalidProductId?), Error>) {
        
        let params = ["product_id": product_id,"quantity":quantity] as [String: Any]
        //Call Common API
        return APIManager.sharedInstance.makeApiCall(serviceType: .addToCart(parameters: params))
            .tryMap { data in
                // Mapping Data into Model
                do {
                    let responseData = try JSONDecoder().decode(AddToCartSuccessResponse.self, from: data)
                    if responseData.status != 200 {
                        let responseData2 = try JSONDecoder().decode(AddToCartInvalidProductId.self, from: data)
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
    
    static  func rateProduct(product_id: String,rating:String) -> (AnyPublisher<(SetProductsRating?, SetProductsRatingInvalidProductId?), Error>) {
        
        let params = ["product_id": product_id,"rating":rating] as [String: Any]
        //Call Common API
        return APIManager.sharedInstance.makeApiCall(serviceType: .setRating(parameters: params))
            .tryMap { data in
                // Mapping Data into Model
                do {
                    let responseData = try JSONDecoder().decode(SetProductsRating.self, from: data)
                    if responseData.status != 200 {
                        let responseData2 = try JSONDecoder().decode(SetProductsRatingInvalidProductId.self, from: data)
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

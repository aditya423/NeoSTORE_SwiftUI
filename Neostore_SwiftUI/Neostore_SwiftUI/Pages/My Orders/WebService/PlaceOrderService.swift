//
//  PlaceOrderService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 13/02/24.
//

import Foundation
import Combine

class PlaceOrderService {
    
    static func placeOrder(address: String) -> (AnyPublisher<(PlaceOrderResponse?, PlaceOrderResponse?, PlaceOrderResponse?, PlaceOrderResponse?), Error>) {
        
        let params = ["address": address]
        return APIManager.sharedInstance.makeApiCall(serviceType: .setOrder(parameters: params))
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(PlaceOrderResponse.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil, nil, nil)
                    } else if responseData.status == 401 {
                        return (nil, responseData, nil, nil)
                    } else if responseData.status == 402 {
                        return (nil, nil, responseData, nil)
                    } else {
                        return (nil, nil, nil, responseData)
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  GetOrderDetailsService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 13/02/24.
//

import Foundation
import Combine

class GetOrderDetailsService {
    
    static func getOrderDetails(orderId: Int) -> (AnyPublisher<(OrderDetailsSuccessResponse?, OrderDetailsInvalidData?), Error>) {
        
        let params = ["order_id": orderId]
        return APIManager.sharedInstance.makeApiCall(serviceType: .getOrderDetail(parameters: params))
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(OrderDetailsSuccessResponse.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil)
                    } else {
                        let invalidData = try JSONDecoder().decode(OrderDetailsInvalidData.self, from: data)
                        return (nil, invalidData)
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

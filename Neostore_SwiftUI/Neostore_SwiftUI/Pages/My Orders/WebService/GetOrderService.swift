//
//  GetOrderService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 13/02/24.
//

import Foundation
import Combine

class GetOrderService {
    
    static func getOrders() -> (AnyPublisher<(OrderListSuccessResponse?, OrderListOrderEmptyResponse?, OrderListInvalidData?), Error>) {
        
        return APIManager.sharedInstance.makeApiCall(serviceType: .getOrderList)
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(OrderListSuccessResponse.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil, nil)
                    } else {
                        let invalidData = try JSONDecoder().decode(OrderListInvalidData.self, from: data)
                        return (nil, nil, invalidData)
                    }
                } catch {
                    do {
                        let responseData = try JSONDecoder().decode(OrderListOrderEmptyResponse.self, from: data)
                        if responseData.status == 200 {
                            return (nil, responseData, nil)
                        } else {
                            let invalidData = try JSONDecoder().decode(OrderListInvalidData.self, from: data)
                            return (nil, nil, invalidData)
                        }
                    } catch {
                        throw error
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}

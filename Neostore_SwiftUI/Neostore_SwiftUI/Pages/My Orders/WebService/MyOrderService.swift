//
//  MyOrderService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 06/02/24.
//

import Foundation
import Combine

class MyOrderService {
    
    static func placeOrder(address: String) -> (AnyPublisher<(PlaceOrderResponse?, PlaceOrderResponse?, PlaceOrderResponse?, PlaceOrderResponse?), Error>) {
        
        let params = ["address": address]
        return APIManager.sharedInstance.makeApiCall(serviceType: .setOrder(parameters: params))
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
    
    static func getOrders() -> (AnyPublisher<(OrderListSuccessResponse?, OrderListOrderEmptyResponse?, OrderListInvalidData?), Error>) {

        APIManager.sharedInstance.makeApiCall(serviceType: .getOrderList)
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
    
    static func getOrderDetails(orderId: Int) -> (AnyPublisher<(OrderDetailsSuccessResponse?, OrderDetailsInvalidData?), Error>) {
        
        let params = ["order_id": orderId]
        return APIManager.sharedInstance.makeApiCall(serviceType: .getOrderDetail(parameters: params))
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

//
//  ListCartItemsService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 31/01/24.
//

import Foundation
import Combine

class ListCartItemsService {
    
    static func getCartItems() -> (AnyPublisher<(ListCartItemsSuccessResponse?, ListCartItemsCartEmpty?, ListCartItemsInvalidToken?, ListCartItemsWrongMethod?), Error>) {
        
        APIManager.sharedInstance.makeApiCall(serviceType: .getCartItems)
            .tryMap { data in
                do {
                    do {
                        let responseData = try JSONDecoder().decode(ListCartItemsSuccessResponse.self, from: data)
                        if responseData.status == 200 {
                            return (responseData, nil, nil, nil)
                        } else if responseData.status == 402 {
                            let invalidToken = try JSONDecoder().decode(ListCartItemsInvalidToken.self, from: data)
                            return (nil, nil, invalidToken, nil)
                        } else {
                            let wrongMethod = try JSONDecoder().decode(ListCartItemsWrongMethod.self, from: data)
                            return (nil, nil, nil, wrongMethod)
                        }
                    } catch {
                        let responseData = try JSONDecoder().decode(ListCartItemsCartEmpty.self, from: data)
                        if responseData.status == 200 {
                            return (nil, responseData, nil, nil)
                        } else if responseData.status == 402 {
                            let invalidToken = try JSONDecoder().decode(ListCartItemsInvalidToken.self, from: data)
                            return (nil, nil, invalidToken, nil)
                        } else {
                            let wrongMethod = try JSONDecoder().decode(ListCartItemsWrongMethod.self, from: data)
                            return (nil, nil, nil, wrongMethod)
                        }
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

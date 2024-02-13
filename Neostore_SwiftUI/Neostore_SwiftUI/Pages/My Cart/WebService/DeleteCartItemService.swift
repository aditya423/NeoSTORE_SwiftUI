//
//  DeleteCartItemService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 02/02/24.
//

import Foundation
import Combine

class DeleteCartItemService {
    
    static func deleteItemFromCart(id: Int) -> (AnyPublisher<(DeleteCartResponse?, DeleteCartInvalidProductId?, DeleteCartInvalidToken?, DeleteCartWrongMethod?), Error>) {
        
        let params = ["product_id": id]
        return APIManager.sharedInstance.makeApiCall(serviceType: .deleteCart(parameters: params))
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(DeleteCartResponse.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil, nil, nil)
                    } else if responseData.status == 401 {
                        let invalidId = try JSONDecoder().decode(DeleteCartInvalidProductId.self, from: data)
                        return (nil, invalidId, nil, nil)
                    } else if responseData.status == 402 {
                        let invalidToken = try JSONDecoder().decode(DeleteCartInvalidToken.self, from: data)
                        return (nil, nil, invalidToken, nil)
                    } else {
                        let wrongMethod = try JSONDecoder().decode(DeleteCartWrongMethod.self, from: data)
                        return (nil, nil, nil, wrongMethod)
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

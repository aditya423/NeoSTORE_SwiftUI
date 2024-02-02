//
//  EditCartItemService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 02/02/24.
//

import Foundation
import Combine

class EditCartItemService {
    
    static func editCartItemQuantity(id: Int, qty: Int) -> (AnyPublisher<(EditCartSuccessResponse?, EditCartInvalidProductId?, EditCartInvalidQuantity?), Error>) {
        
        let params = ["product_id": id, "quantity": qty]
        return APIManager.sharedInstance.makeApiCall(serviceType: .editCart(parameters: params))
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(EditCartSuccessResponse.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil, nil)
                    } else if responseData.status == 500 {
                        let invalidId = try JSONDecoder().decode(EditCartInvalidProductId.self, from: data)
                        return (nil, invalidId, nil)
                    } else {
                        let invalidQty = try JSONDecoder().decode(EditCartInvalidQuantity.self, from: data)
                        return (nil, nil, invalidQty)
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  FetchAccountDetailsService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation
import Combine

class AccountDetailsService {
    
    static func getAccountDetails() -> (AnyPublisher<(FetchAccountDetails?, AccountDetailsInvalidToken?, AccountDetailsWrongMethod?), Error>) {
        APIManager.sharedInstance.makeApiCall(serviceType: .fetchAccountDetails)
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(FetchAccountDetails.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil, nil)
                    } else if responseData.status == 402 {
                        let invalidResponseData = try JSONDecoder().decode(AccountDetailsInvalidToken.self, from: data)
                        return (nil, invalidResponseData, nil)
                    } else {
                        let wrongMethodData = try JSONDecoder().decode(AccountDetailsWrongMethod.self, from: data)
                        return (nil, nil, wrongMethodData)
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

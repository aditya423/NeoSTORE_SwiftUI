//
//  LoginService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 19/01/24.
//

import Foundation
import Combine

class LoginService {
    
    static func loginUser(email: String, password: String) -> (AnyPublisher<(LoginSuccessResponse?, LoginErrorResponse?), Error>) {
        
        let params = ["email": email, "password": password] as [String: Any]
        return APIManager.sharedInstance.makeApiCall(serviceType: .userLogin(parameters: params))
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(LoginSuccessResponse.self, from: data)
                    return (responseData, nil)
                } catch {
                    do {
                        let responseData2 = try JSONDecoder().decode(LoginErrorResponse.self, from: data)
                        return (nil, responseData2)
                    } catch {
                        throw error
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}

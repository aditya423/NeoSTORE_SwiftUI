//
//  LoginService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 19/01/24.
//

import Foundation
import Combine
//MARK: - LoginService
class LoginService {
    
    static func loginUser(email: String, password: String) -> (AnyPublisher<(LoginSuccessResponse?, LoginErrorResponse?), Error>) {
        
        let params = ["email": email, "password": password] as [String: Any]
        // Call Common API Function
        return APIManager.sharedInstance.makeApiCall(serviceType: .userLogin(parameters: params))
        // operator which receives data, make changes and publishes that data
            .tryMap { data in
                //Mapping response in Model
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

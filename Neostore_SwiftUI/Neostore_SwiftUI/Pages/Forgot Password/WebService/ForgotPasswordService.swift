//
//  ForgotPasswordService.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 30/01/24.
//

import Foundation
import Combine
//MARK: - ForgotPasswordService
class ForgotPasswordService {
    
    static func forgotPassword(email:String) -> (AnyPublisher<(ResetPasswordResponse?,ResetPasswordResponse?), Error>) {
        
        let params = ["email": email] as [String: Any]
        //Calling Common API Function
        return APIManager.sharedInstance.makeApiCall(serviceType: .forgotPassword(parameters: params))
        // operator which receives data, make changes and publishes that data
            .tryMap { data in
                //Mapping Data into Model
                do {
                    let responseData = try JSONDecoder().decode(ResetPasswordResponse.self, from: data)
                    if responseData.status == 200{
                        return (responseData, nil)
                    }
                    return (nil, responseData)
                }
                catch {
                    do {
                        let responseData = try JSONDecoder().decode(ResetPasswordResponse.self, from: data)
                        return (nil, responseData)
                    }
                    catch {
                        throw error
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}

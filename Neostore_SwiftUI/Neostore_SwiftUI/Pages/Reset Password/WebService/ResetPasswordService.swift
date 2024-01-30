
//
//  ResetPasswordService.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 29/01/24.
//

import Foundation
import Combine

class ResetPasswordService {
    
    static func resetUserPassword(oldPassword:String, newPassword: String, confirmPassword: String) -> (AnyPublisher<(RegisterSuccessResponse?, RegisterDataAlreadyExist?, RegisterErrorResponse?), Error>) {
        
        let params = ["old_password": oldPassword, "password": newPassword, "confirm_password": confirmPassword] as [String: Any]
        
        return APIManager.sharedInstance.makeApiCall(serviceType: .forgotPassword(parameters: params))
        // operator which receives data, make changes and publishes that data
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(RegisterSuccessResponse.self, from: data)
                    if responseData.status == 422 {
                        let responseData2 = try JSONDecoder().decode(RegisterDataAlreadyExist.self, from: data)
                        return (nil, responseData2, nil)
                    }
                    return (responseData, nil, nil)
                }
                catch {
                    do {
                        let responseData = try JSONDecoder().decode(RegisterErrorResponse.self, from: data)
                        return (nil, nil, responseData)
                    }
                    catch {
                        throw error
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}

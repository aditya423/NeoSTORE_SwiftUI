
//
//  ResetPasswordService.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 29/01/24.
//

import Foundation
import Combine

class ResetPasswordService {
    
    static func resetUserPassword(oldPassword:String, newPassword: String, confirmPassword: String) -> (AnyPublisher<(ResetPasswordResponse?,String?), Error>) {
        
        let params = ["old_password": oldPassword, "password": newPassword, "confirm_password": confirmPassword] as [String: Any]
        
        return APIManager.sharedInstance.makeApiCall(serviceType: .changePassword(parameters: params))
        // operator which receives data, make changes and publishes that data
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(ResetPasswordResponse.self, from: data)
                    if responseData.status == 200{
                        return (responseData, nil)
                    }
                    return (nil, responseData.userMsg)
                }
                catch {
                        throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

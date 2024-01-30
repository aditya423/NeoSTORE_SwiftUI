//
//  RegisterService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 18/01/24.
//

import Foundation
import Combine

class RegisterService {
    
    static func registerUser(firstName: String, lastName: String, email: String, password: String, confirmPassword: String, gender: String, number: Int) -> (AnyPublisher<(RegisterSuccessResponse?, RegisterDataAlreadyExist?, RegisterErrorResponse?), Error>) {
        
        let params = ["first_name": firstName, "last_name": lastName, "email": email, "password": password, "confirm_password": confirmPassword, "gender": gender, "phone_no": number] as [String: Any]
        
        return APIManager.sharedInstance.makeApiCall(serviceType: .userRegister(parameters: params))
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

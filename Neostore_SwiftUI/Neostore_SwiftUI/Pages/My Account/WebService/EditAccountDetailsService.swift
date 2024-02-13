//
//  EditAccountDetailsService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 09/02/24.
//

import Foundation
import Combine

class EditAccountDetailsService {
    
    static func editAccountDetails(firstName: String, lastName: String, email: String, dob: String, profilePic: String, phoneNo: String) -> (AnyPublisher<(UpdateAccountSuccessResponse?, UpdateAccountFailed?, UpdateAccountInvalidData?), Error>) {
        
        let params = ["first_name": firstName, "last_name": lastName, "email": email, "dob": dob, "profile_pic": profilePic, "phone_no": phoneNo]
        return APIManager.sharedInstance.makeApiCall(serviceType: .updateAccount(parameters: params))
        // OPERATOR -> which receives data, make changes and publishes that data
        // used for DECODING data into model
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(UpdateAccountSuccessResponse.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil, nil)
                    } else if responseData.status == 500 {
                        let updateFailed = try JSONDecoder().decode(UpdateAccountFailed.self, from: data)
                        return (nil, updateFailed, nil)
                    } else {
                        let invalidData = try JSONDecoder().decode(UpdateAccountInvalidData.self, from: data)
                        return (nil, nil, invalidData)
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  UpdateAccountDetails.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

struct UpdateAccountRequest: Codable {
    let firstName, lastName, email, dob, profilePic, phoneNo: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email, dob
        case profilePic = "profile_pic"
        case phoneNo = "phone_no"
    }
}

struct UpdateAccountSuccessResponse: Codable {
    let status: Int?
    let data: UserDetails?
    let message, userMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct UpdateAccountFailed: Codable {
    let status: Int?
    let data: Bool?
    let message, userMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct UpdateAccountInvalidData: Codable {
    let status: Int?
    let message, userMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case userMsg = "user_msg"
    }
}

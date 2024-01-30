//
//  UpdateAccountDetails.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

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

//
//  ResetPassword.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

struct ResetPasswordRequest: Codable {
    let oldPassword, password, confirmPassword: String?
    
    enum CodingKeys: String, CodingKey {
        case oldPassword = "old_password"
        case password
        case confirmPassword = "confirm_password"
    }
}

struct ResetPasswordResponse: Codable {
    let status: Int?
    let message, userMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case userMsg = "user_msg"
    }
}

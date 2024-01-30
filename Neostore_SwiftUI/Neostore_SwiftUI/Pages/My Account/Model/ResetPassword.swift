//
//  ResetPassword.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

struct ResetPasswordResponse: Codable {
    let status: Int?
    let message, userMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case userMsg = "user_msg"
    }
}

//
//  PlaceOrder.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 06/02/24.
//

import Foundation

struct PlaceOrderResponse : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

//
//  EditCartItems.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

struct EditCartRequest : Codable {
    let product_id : Int?
    let quantity : Int?
    
    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
        case quantity = "quantity"
    }
}

struct EditCartSuccessResponse : Codable {
    let status : Int?
    let data : Bool?
    let total_carts : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case total_carts = "total_carts"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct EditCartInvalidProductId : Codable {
    let status : Int?
    let data : Bool?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct EditCartInvalidQuantity : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

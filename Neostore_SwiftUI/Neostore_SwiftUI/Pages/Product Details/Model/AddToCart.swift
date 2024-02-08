//
//  AddToCart.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation
//MARK: - AddToCartSuccessResponse
struct AddToCartSuccessResponse : Codable {
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

//MARK: - AddToCartInvalidProductId
struct AddToCartInvalidProductId : Codable {
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

//MARK: - AddToCartInvalidQuantity
struct AddToCartInvalidQuantity : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

//MARK: - AddToCartInvalidToken
struct AddToCartInvalidToken : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

//MARK: - AddToCartWrongMethod
struct AddToCartWrongMethod : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

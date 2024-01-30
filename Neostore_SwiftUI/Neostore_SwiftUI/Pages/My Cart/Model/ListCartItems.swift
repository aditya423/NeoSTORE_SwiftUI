//
//  ListCartItems.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

struct ListCartItemsSuccessResponse : Codable {
    let status : Int?
    let data : [ListCartItemsData]?
    let count : Int?
    let total : Double?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case count = "count"
        case total = "total"
    }
}

struct ListCartItemsData : Codable {
    let id : Int?
    let product_id : Int?
    let quantity : Int?
    let product : ListCartItemsProduct?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product_id = "product_id"
        case quantity = "quantity"
        case product = "product"
    }
}

struct ListCartItemsProduct : Codable {
    let id : Int?
    let name : String?
    let cost : Int?
    let product_category : String?
    let product_images : String?
    let sub_total : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case cost = "cost"
        case product_category = "product_category"
        case product_images = "product_images"
        case sub_total = "sub_total"
    }
}

struct ListCartItemsCartEmpty : Codable {
    let status : Int?
    let data : String?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct ListCartItemsInvalidToken : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct ListCartItemsWrongMethod : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

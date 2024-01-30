//
//  ProductDetails.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

// MARK: REQUEST

struct RequestProductDetails : Codable {
    let product_id : Int?
    
    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
    }
}

// MARK: RESPONSE

struct ProductDetailsResponse : Codable {
    let status : Int?
    let data : ProductDetails?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

struct ProductDetails : Codable {
    let id : Int?
    let product_category_id : Int?
    let name : String?
    let producer : String?
    let description : String?
    let cost : Int?
    let rating : Int?
    let view_count : Int?
    let created : String?
    let modified : String?
    let product_images : [ProductImages]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product_category_id = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case view_count = "view_count"
        case created = "created"
        case modified = "modified"
        case product_images = "product_images"
    }
}

struct ProductImages : Codable {
    let id : Int?
    let product_id : Int?
    let image : String?
    let created : String?
    let modified : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product_id = "product_id"
        case image = "image"
        case created = "created"
        case modified = "modified"
    }
}

// MARK: ERROR

struct ProductDetailsWrongMethod : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct ProductDetailsInvalidCategory : Codable {
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

struct ProductDetailsDataMissing : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

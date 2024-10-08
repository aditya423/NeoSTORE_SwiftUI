//
//  ProductListing.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

// MARK: RESPONSE
struct ProductListResponse : Codable {
    let status : Int?
    let data : [ProductListDetails]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

//MARK: - ProductListDetails
struct ProductListDetails : Codable {
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
    let product_images : String?
    
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

// MARK: ERROR
//MARK: - ProductListWrongMethod
struct ProductListWrongMethod : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

//MARK: - ProductListInvalidCategoryId
struct ProductListInvalidCategoryId : Codable {
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

//MARK: - ProductListDataMissing
struct ProductListDataMissing : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

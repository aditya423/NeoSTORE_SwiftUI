//
//  OrderDetails.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

struct OrderDetailsVars {
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
    var order_details: OrderDetailsOverview?
    var product_details: [OrderDetails]?
}

struct OrderDetailsSuccessResponse : Codable {
    let status : Int?
    let data : OrderDetailsOverview?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

struct OrderDetailsOverview : Codable {
    let id : Int?
    let cost : Double?
    let created : String?
    let order_details : [OrderDetails]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cost = "cost"
        case created = "created"
        case order_details = "order_details"
    }
}

struct OrderDetails : Codable {
    let id : Int?
    let order_id : Int?
    let product_id : Int?
    let quantity : Int?
    let total : Int?
    let prod_name : String?
    let prod_cat_name : String?
    let prod_image : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case order_id = "order_id"
        case product_id = "product_id"
        case quantity = "quantity"
        case total = "total"
        case prod_name = "prod_name"
        case prod_cat_name = "prod_cat_name"
        case prod_image = "prod_image"
    }
}

struct OrderDetailsInvalidData : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

//
//  OrderList.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation

struct OrderListVars {
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
}

struct OrderListSuccessResponse : Codable {
    let status : Int?
    let data : [OrderList]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

struct OrderList : Codable {
    let id : Int?
    let cost : Double?
    let created : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cost = "cost"
        case created = "created"
    }
}

struct OrderListOrderEmptyResponse : Codable {
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

struct OrderListInvalidData : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

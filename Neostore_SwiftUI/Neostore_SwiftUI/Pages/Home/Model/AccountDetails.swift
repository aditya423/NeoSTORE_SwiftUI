//
//  AccountDetails.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 30/01/24.
//

import Foundation
//MARK: - FetchAccountDetails
struct FetchAccountDetails : Codable {
    let status : Int?
    let data : FetchedData?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}

//MARK: - FetchedData
struct FetchedData : Codable {
    let user_data : UserDetails?
    let product_categories : [ProductCategories]?
    let total_carts : Int?
    let total_orders : Int?
    
    enum CodingKeys: String, CodingKey {
        case user_data = "user_data"
        case product_categories = "product_categories"
        case total_carts = "total_carts"
        case total_orders = "total_orders"
    }
}

//MARK: - UserDetails
struct UserDetails: Codable {
    var id: Int?
    var role_id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var username: String?
    var gender: String?
    var phone_no: String?
    var is_active: Bool?
    var created: String?
    var modified: String?
    var access_token: String?
    var dob: String?
    var profile_pic: String?
    
    enum codingKeys: String,CodingKey {
        case id = "id"
        case role_id = "role_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case username = "username"
        case gender = "gender"
        case phone_no = "phone_no"
        case is_active = "is_active"
        case created = "created"
        case modified = "modified"
        case access_token = "access_token"
        case dob = "dob"
        case profile_pic = "profile_pic"
    }
}
//MARK: - ProductCategories
struct ProductCategories : Codable {
    let id : Int?
    let name : String?
    let icon_image : String?
    let created : String?
    let modified : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon_image = "icon_image"
        case created = "created"
        case modified = "modified"
    }
}

//MARK: - AccountDetailsInvalidToken
struct AccountDetailsInvalidToken : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

//MARK: - AccountDetailsWrongMethod
struct AccountDetailsWrongMethod : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

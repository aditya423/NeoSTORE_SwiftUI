//
//  RegisterModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 18/01/24.
//

import Foundation
import SwiftUI

struct RegisterSuccessResponse: Codable {
    let status: Int?
    let data: RegisterDetails?
    let message, userMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct RegisterDetails: Codable {
    let id, roleID: Int?
    let firstName, lastName, email, username: String?
    let profilePic, countryID, gender: String?
    let phoneNo: String?
    let dob: String?
    let isActive: Bool?
    let created, modified: String?
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case roleID = "role_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, username
        case profilePic = "profile_pic"
        case countryID = "country_id"
        case gender
        case phoneNo = "phone_no"
        case dob
        case isActive = "is_active"
        case created, modified
        case accessToken = "access_token"
    }
}

struct RegisterErrorResponse : Codable {
    let status : Int?
    let data : RegisterDataAlreadyExist?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}
struct RegisterDataAlreadyExist : Codable {
    let first_name : String?
    let last_name : String?
    let email : String?
    let gender : String?
    let phone_no : Int?
    
    enum CodingKeys: String, CodingKey {
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case gender = "gender"
        case phone_no = "phone_no"
    }
}

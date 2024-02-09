//
//  LoginModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 18/01/24.
//

import Foundation
//MARK: - NavPublishVars
struct NavPublishVars {
    var isNavigating = false
    var showAlert = false
    var alertMessage = ""
    var isLoading = false
}

//MARK: - LoginSuccessResponse
struct LoginSuccessResponse: Codable {
    let status: Int?
    let data: LoginDetails?
    let message, userMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

//MARK: - LoginDetails
struct LoginDetails: Codable {
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

//MARK: - LoginErrorResponse
struct LoginErrorResponse : Codable {
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

//MARK: - LoginDataMissing
struct LoginDataMissing : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}


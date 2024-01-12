//
//  APIService.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import Foundation

let DEV_ROOT_POINT = "http://staging.php-dev.in:8844/trainingapp"
let PROD_ROOT_POINT = ""

enum NetworkEnvironment: String {
    case development
    case production
}

var networkEnvironment: NetworkEnvironment {
    return .development
}

var BaseURL: String {
    switch networkEnvironment {
    case .development :
        return DEV_ROOT_POINT
    case .production :
        return PROD_ROOT_POINT
    }
}

typealias stringAnyDict = [String: Any]
typealias stringStringDict = [String: String]
let contentKey = "Content-Type"
let contentValue = "application/x-www-form-urlencoded"

enum APIServices {
    case userRegister(parameters: stringAnyDict)
    case userLogin(parameters: stringAnyDict)
    case forgotPassword(parameters: stringAnyDict)
    case changePassword(parameters: stringAnyDict)
    case updateAccount(parameters: stringAnyDict)
    case fetchAccountDetails
    case getProductList(parameters: stringAnyDict)
    case getProductDetails(parameters: stringAnyDict)
    case setRating(parameters: stringAnyDict)
    case addToCart(parameters: stringAnyDict)
    case editCart(parameters: stringAnyDict)
    case deleteCart(parameters: stringAnyDict)
    case getCartItems
    case setOrder(parameters: stringAnyDict)
    case getOrderList
    case getOrderDetail(parameters: stringAnyDict)
}

extension APIServices {
    var Path: String {
        let apiDomain = "/api/"
        var servicePath: String = ""
        switch self {
        case .userRegister: servicePath = apiDomain + "users/register"
        case .userLogin: servicePath = apiDomain + "users/login"
        case .forgotPassword: servicePath = apiDomain + "users/forgot"
        case .changePassword: servicePath = apiDomain + "users/change"
        case .updateAccount: servicePath = apiDomain + "users/update"
        case .fetchAccountDetails: servicePath = apiDomain + "users/getUserData"
        case .getProductList: servicePath = apiDomain + "products/getList"
        case .getProductDetails: servicePath = apiDomain + "products/getDetail"
        case .setRating: servicePath = apiDomain + "products/setRating"
        case .addToCart: servicePath = apiDomain + "addToCart"
        case .editCart: servicePath = apiDomain + "editCart"
        case .deleteCart: servicePath = apiDomain + "deleteCart"
        case .getCartItems: servicePath = apiDomain + "cart"
        case .setOrder: servicePath = apiDomain + "order"
        case .getOrderList: servicePath = apiDomain + "orderList"
        case .getOrderDetail: servicePath = apiDomain + "orderDetail"
        }
        return BaseURL + servicePath
    }
    
    var httpMethod: String {
        switch self {
        case .fetchAccountDetails, .getProductList, .getProductDetails, .getCartItems, .getOrderList, .getOrderDetail :
            return "GET"
        default:
            return "POST"
        }
    }
    
    var parameters: stringAnyDict? {
        switch self {
        case .userRegister(parameters: let param), .userLogin(let param), .forgotPassword(let param), .changePassword(let param), .updateAccount(let param), .getProductList(let param), .getProductDetails(let param), .setRating(let param), .addToCart(let param), .editCart(let param), .deleteCart(let param), .setOrder(let param), .getOrderDetail(let param) :
            return param
        default:
            return nil
        }
    }
    
    var header: stringStringDict {
        var headerDict: stringStringDict = ["":""]
        headerDict[contentKey] = contentValue
        
        switch self {
        case .changePassword(_), .updateAccount(_), .fetchAccountDetails, .addToCart(_), .editCart(_), .deleteCart(_), .getCartItems, .setOrder(_), .getOrderList, .getOrderDetail(_):
            let accessToken = UserDefaults.standard.getUserToken() ?? "NO TOKEN"
            headerDict = [contentKey: contentValue,
                          "access_token": accessToken]
        default:
            break
        }
        return headerDict
    }
}

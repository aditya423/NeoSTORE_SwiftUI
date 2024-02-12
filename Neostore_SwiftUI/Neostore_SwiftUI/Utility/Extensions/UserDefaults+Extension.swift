//
//  Extensions.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import Foundation
//MARK:- UserDefaultKeys
enum UserDefaultKeys: String {
    case isLoggedIn
    case userToken
    case address
    case password
}

//MARK: - UserDefaults functions
extension UserDefaults {
    func getUserToken() -> String? {
        return string(forKey: UserDefaultKeys.userToken.rawValue)
    }
    func setUserToken(value: String?) {
        set(value, forKey: UserDefaultKeys.userToken.rawValue)
    }
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
    func setPassword(value: String) {
        set(value, forKey: UserDefaultKeys.password.rawValue)
    }
    func getPassword() -> String? {
        return string(forKey: UserDefaultKeys.password.rawValue)
    }
}

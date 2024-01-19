//
//  LoginViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import Foundation
import SwiftUI

struct LoginViewModel {
    
    @Binding var isNavigating: Bool
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
    let validation = Validation()
    
    func validateLoginDetails(userName: String, password: String){
        if let result = validation.loginValidation(email: userName, password: password){
            alertMessage = result
            showAlert = true
        } else {
            isNavigating = true
        }
    }
}

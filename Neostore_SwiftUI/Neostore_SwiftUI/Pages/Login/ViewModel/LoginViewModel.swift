//
//  LoginViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    // VARIABLES
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    @Published var vmVars = NavPublishVars()
    
    func loginUserProfile(email: String, password: String) {
        guard !email.isEmpty && !password.isEmpty else {
            vmVars.alertMessage = AlertMessages.fillAllFieldsMsg.rawValue
            vmVars.showAlert = true
            return
        }
        // VALIDATION CHECK
        if let result = validation.loginValidation(email: email, password: password) {
            if result == "" {
                // API CALL
                LoginService.loginUser(email: email, password: password)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.vmVars.alertMessage = error.localizedDescription
                            self.vmVars.showAlert = true
                        }
                    }, receiveValue: { (success, error) in
                        if success != nil {
                            UserDefaults.standard.setLoggedIn(value: true)
                            UserDefaults.standard.setUserToken(value: success?.data?.accessToken)
                            UserDefaults.standard.setPassword(value: password)
                            self.vmVars.isNavigating = true
                        } else if error != nil {
                            self.vmVars.isNavigating = false
                            self.vmVars.alertMessage = error?.user_msg ?? ""
                            self.vmVars.showAlert = true
                        }
                    })
                    .store(in: &cancellables)
            } else {
                self.vmVars.alertMessage = result
                self.vmVars.showAlert = true
            }
        }
    }
}

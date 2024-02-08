//
//  LoginViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import Foundation
import SwiftUI
import Combine
//MARK: - LoginViewModel
class LoginViewModel: ObservableObject {
    //Publisher
    @Published var vmVars = NavPublishVars()
    
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    // Api Call
    func loginUserProfile(email: String, password: String) {
        guard !email.isEmpty && !password.isEmpty else {
            vmVars.alertMessage = AlertMessages.fillAllFieldsMsg.rawValue
            vmVars.showAlert = true
            return
        }
        // Validation
        if let result = validation.loginValidation(email: email, password: password) {
            if result == "" {
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
                        // On Success Set UserDefauls and Navigate or Show Alert
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

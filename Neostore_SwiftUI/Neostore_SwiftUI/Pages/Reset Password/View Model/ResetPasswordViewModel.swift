//
//  ResetPasswordViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 29/01/24.
//

import Foundation
import SwiftUI
import Combine

class ResetPasswordViewModel: ObservableObject{
    
    @Published var vmVars = NavPublishVars()
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()

    func resetUserPassword(oldPassword: String, newPassword:String,confirmPassword: String){
        guard !oldPassword.isEmpty && !newPassword.isEmpty && !confirmPassword.isEmpty else {
            vmVars.alertMessage = AlertMessages.fillAllFieldsMsg.rawValue
            vmVars.showAlert = true
            return
        }
        
        if let result = validation.resetPassValidation(oldPass: oldPassword, newPass: newPassword, confirmPass: confirmPassword) {
            if result == "" {
                if newPassword == confirmPassword {
                    ResetPasswordService.resetUserPassword(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
                        .sink (receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                self.vmVars.alertMessage = error.localizedDescription
                                self.vmVars.showAlert = true
                            }
                        }, receiveValue: { (success , errorMsg) in
                            if success != nil {
                                UserDefaults.standard.setPassword(value: newPassword)
                                UserDefaults.standard.setLoggedIn(value: false)
                                UserDefaults.standard.setUserToken(value: nil)
                                self.vmVars.isNavigating = true
                            } else if errorMsg != nil {
                                self.vmVars.isNavigating = false
                                self.vmVars.alertMessage = errorMsg ?? ""
                                self.vmVars.showAlert = true
                            }
                        })
                        .store(in: &cancellables)
                } else {
                    vmVars.alertMessage = AlertMessages.passwordDidntMatched.rawValue
                    vmVars.showAlert = true
                }
            } else {
                vmVars.alertMessage = result
                vmVars.showAlert = true
            }
        }
    }
}

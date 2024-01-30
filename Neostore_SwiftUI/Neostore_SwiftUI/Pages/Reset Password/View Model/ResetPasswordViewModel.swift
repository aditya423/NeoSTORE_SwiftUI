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
                        .sink { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                self.vmVars.alertMessage = error.localizedDescription
                                self.vmVars.showAlert = true
                            }
                        } receiveValue: { (success , error) in
                            if success != nil {
                                self.vmVars.isNavigating = true
                            } else if error != nil {
                                self.vmVars.isNavigating = false
                                self.vmVars.alertMessage = error.debugDescription
                                self.vmVars.showAlert = true
                            }
                        }.store(in: &cancellables)
                    //                    RegisterService.registerUser(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, gender: genderSelected, number: Int(mobileNumber) ?? 0)
                    //                        .sink(receiveCompletion: { completion in
                    //                            switch completion {
                    //                            case .finished:
                    //                                break
                    //                            case .failure(let error):
                    //                                self.vmVars.alertMessage = error.localizedDescription
                    //                                self.vmVars.showAlert = true
                    //                            }
                    //                        }, receiveValue: { (success, alreadyExists, error) in
                    //                            if success != nil {
                    //                                self.vmVars.isNavigating = true
                    //                            } else if alreadyExists != nil {
                    //                                self.vmVars.isNavigating = false
                    //                                self.vmVars.alertMessage = AlertMessages.userAlreadyExists.rawValue
                    //                                self.vmVars.showAlert = true
                    //                            } else if error != nil {
                    //                                self.vmVars.isNavigating = false
                    //                                self.vmVars.alertMessage = error.debugDescription
                    //                                self.vmVars.showAlert = true
                    //                            }
                    //                        })
                    //                        .store(in: &cancellables)
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

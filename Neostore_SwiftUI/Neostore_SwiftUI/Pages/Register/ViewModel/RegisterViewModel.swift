//
//  RegisterViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 18/01/24.
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    
    // VARIABLES
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    @Published var vmVars = NavPublishVars()

    func registerUserProfile(firstName: String, lastName: String, email: String, password: String, confirmPassword: String, mobileNumber: String, isTermsAccepted: Bool, genderSelected: String){
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !mobileNumber.isEmpty && isTermsAccepted && !genderSelected.isEmpty else {
            vmVars.alertMessage = AlertMessages.fillAllFieldsMsg.rawValue
            vmVars.showAlert = true
            return
        }
        // VALIDATION CHECK
        if let result = validation.registerValidation(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, mobileNumber: mobileNumber) {
            if result == "" {
                if password == confirmPassword {
                    // API CALL
                    RegisterService.registerUser(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, gender: genderSelected, number: Int(mobileNumber) ?? 0)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                self.vmVars.alertMessage = error.localizedDescription
                                self.vmVars.showAlert = true
                            }
                        }, receiveValue: { (success, alreadyExists, error) in
                            // On Success navigate else Show Alert
                            if success != nil {
                                self.vmVars.isNavigating = true
                            } else if alreadyExists != nil {
                                self.vmVars.isNavigating = false
                                self.vmVars.alertMessage = AlertMessages.userAlreadyExists.rawValue
                                self.vmVars.showAlert = true
                            } else if error != nil {
                                self.vmVars.isNavigating = false
                                self.vmVars.alertMessage = error.debugDescription
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

//
//  ForgotPasswordViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 30/01/24.
//

import Foundation
import SwiftUI
import Combine

class ForgotPasswordViewModel: ObservableObject{
    
    // VARIABLES
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    @Published var vmVars = NavPublishVars()
    
    func forgotPassword(email: String){
        // VALIDATION CHECK
        guard !email.isEmpty else {
            vmVars.alertMessage = AlertMessages.fillAllFieldsMsg.rawValue
            vmVars.showAlert = true
            return
        }
        
        // API CALL
        ForgotPasswordService.forgotPassword(email: email)
            .sink (receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success , error) in
                // On Success Navigate else Dont
                if success != nil {
                    self.vmVars.isNavigating = true
                    self.vmVars.alertMessage = success?.userMsg ?? ""
                    self.vmVars.showAlert = true
                } else if error != nil {
                    self.vmVars.isNavigating = false
                    self.vmVars.alertMessage = error?.userMsg ?? ""
                    self.vmVars.showAlert = true
                }
            })
            .store(in: &cancellables)
    }
}

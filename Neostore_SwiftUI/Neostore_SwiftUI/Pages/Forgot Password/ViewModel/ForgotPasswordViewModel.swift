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
    
    @Published var vmVars = NavPublishVars()
    let validation = Validation()
    private var cancellables = Set<AnyCancellable>()
    
    func forgotPassword(email: String){
        guard !email.isEmpty else {
            vmVars.alertMessage = AlertMessages.fillAllFieldsMsg.rawValue
            vmVars.showAlert = true
            return
        }
        
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
                if success != nil {
                    self.vmVars.isNavigating = true
                } else if error != nil {
                    self.vmVars.isNavigating = false
                    self.vmVars.alertMessage = error?.userMsg ?? ""
                    self.vmVars.showAlert = true
                }
            })
            .store(in: &cancellables)
    }
}

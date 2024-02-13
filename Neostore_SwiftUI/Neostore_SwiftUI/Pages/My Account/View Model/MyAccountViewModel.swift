//
//  MyAccountViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 29/01/24.
//

import Foundation
import SwiftUI
import Combine

class MyAccountViewModel: ObservableObject{
    
    // VARIABLES
    private var cancellables = Set<AnyCancellable>()
    @Published var vmVars = NavPublishVars()
    
    // VALIDATION
    func isDataChanged(oldFirstName: String, oldLastName: String, oldEmail: String, oldMobileNo: String, oldDob: String, firstName: String, lastName: String, email: String, mobileNo: String, dob: String) -> Bool {
        if oldFirstName==firstName && oldLastName==lastName && oldEmail==email && oldMobileNo==mobileNo && oldDob==dob {
            return false
        }
        return true
    }
    
    // API CALL
    func editAccountDetails(firstName: String, lastName: String, email: String, dob: String, profilePic: String, phoneNo: String) {
        EditAccountDetailsService.editAccountDetails(firstName: firstName, lastName: lastName, email: email, dob: dob, profilePic: profilePic, phoneNo: phoneNo)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.vmVars.alertMessage = error.localizedDescription
                    self.vmVars.showAlert = true
                }
            }, receiveValue: { (success, updateFailed, invalidData) in
                if success != nil {
                    CommonViewModel.shared.user_data = success?.data
                    self.vmVars.isLoading = false
                } else if updateFailed != nil {
                    self.vmVars.alertMessage = updateFailed?.userMsg ?? AlertMessages.updateFailedMsg.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                } else {
                    self.vmVars.alertMessage = invalidData?.userMsg ?? AlertMessages.invalidDataOrToken.rawValue
                    self.vmVars.showAlert = true
                    self.vmVars.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
}

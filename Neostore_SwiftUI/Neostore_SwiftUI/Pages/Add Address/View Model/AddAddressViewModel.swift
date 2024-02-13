//
//  AddAddressViewModel.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 31/01/24.
//

import Foundation
import SwiftUI
import Combine


class AddAddressViewModel: ObservableObject{
    
    @Published var vmVars = AddAddressPublishers()
    
    func validateTextFields(address: String, landmark: String, city: String, state: String, zipcode: String, country: String) -> Bool {
        if address.isEmpty || landmark.isEmpty || city.isEmpty || state.isEmpty || zipcode.isEmpty || country.isEmpty {
            vmVars.showAlert = true
            vmVars.alertMessage = AlertMessages.fillAllFieldsMsg.rawValue
            return false
        }
        return true
    }
}

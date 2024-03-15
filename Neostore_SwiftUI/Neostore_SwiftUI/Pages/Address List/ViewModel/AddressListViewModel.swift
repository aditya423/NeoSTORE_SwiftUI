//
//  AddressListViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 05/02/24.
//

import Foundation

class AddressListViewModel: ObservableObject {
    
    // VARIABLES
    @Published var address: [String?]? = []
    
    // FUNCTIONS
    func setAddress() {
        address = [UserDefaults.standard.string(forKey: Keys.fullAddress.rawValue)]
    }
    
    func removeAddress() {
        UserDefaults.standard.removeObject(forKey: Keys.fullAddress.rawValue)
        self.address = [UserDefaults.standard.string(forKey: Keys.fullAddress.rawValue)]
    }
}

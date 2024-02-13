//
//  CommonViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 05/02/24.
//

import Foundation

class CommonViewModel {
    
    static let shared = CommonViewModel()
    
    // VARIABLES
    @Published var total_carts: String?
    @Published var user_data: UserDetails?
    @Published var isImageUpdated: Bool?
}

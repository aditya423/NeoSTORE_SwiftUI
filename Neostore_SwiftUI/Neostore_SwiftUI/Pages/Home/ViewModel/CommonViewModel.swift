//
//  CommonViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 05/02/24.
//

import Foundation

class CommonViewModel {
    static let shared = CommonViewModel()
    
    @Published var total_carts: String?
}

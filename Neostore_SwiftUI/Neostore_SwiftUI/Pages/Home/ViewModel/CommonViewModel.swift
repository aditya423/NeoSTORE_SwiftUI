//
//  CommonViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 05/02/24.
//

import Foundation
//MARK: - CommonViewModel
class CommonViewModel {
    static let shared = CommonViewModel()  //For access of TotalCarts to mulitple viewControllers
    
    @Published var total_carts: String?
    @Published var user_data: UserDetails?
}

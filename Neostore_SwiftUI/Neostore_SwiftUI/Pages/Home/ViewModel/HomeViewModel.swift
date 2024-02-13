//
//  HomeViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import Foundation
//MARK: - HomeViewModel
class HomeViewModel {
    var productsImages = ["slider_img1", "slider_img2", "slider_img3", "slider_img4"]
    //Static for Use from product list and product details
    static var furnitureData: [Int: [String: Any]] = [
        0: ["name":"Tables","lblPosition":Position.topRight,"imgName":"table","imgPosition": Position.bottomLeft,"categoryID":"1"],
        1: ["name":"Sofas","lblPosition":Position.bottomLeft,"imgName":"sofa","imgPosition": Position.topRight, "categoryID":"2"],
        2: ["name":"Chairs","lblPosition":Position.topLeft,"imgName":"chair","imgPosition": Position.bottomRight, "categoryID":"3"],
        3: ["name":"Cupboards","lblPosition":Position.bottomRight,"imgName":"cupboard","imgPosition": Position.topLeft,"categoryID":"4"]
    ]
}

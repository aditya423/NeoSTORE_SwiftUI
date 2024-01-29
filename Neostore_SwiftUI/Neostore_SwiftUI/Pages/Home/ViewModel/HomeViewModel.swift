//
//  HomeViewModel.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 24/01/24.
//

import Foundation

enum Position {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

class HomeViewModel {
    var productsImages = ["slider_img1", "slider_img2", "slider_img3", "slider_img4"]
    var furnitureData: [Int: [String: Any]] = [
        0: ["name":"Table","lblPosition":Position.topRight,"imgName":"table","imgPosition":Position.bottomLeft],
        1: ["name":"Sofas","lblPosition":Position.bottomLeft,"imgName":"sofa","imgPosition":Position.topRight],
        2: ["name":"Chairs","lblPosition":Position.topLeft,"imgName":"chair","imgPosition":Position.bottomRight],
        3: ["name":"Cupboards","lblPosition":Position.bottomRight,"imgName":"cupboard","imgPosition":Position.topLeft]
    ]
}

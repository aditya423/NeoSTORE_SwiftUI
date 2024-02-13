//
//  MKCoordinateRegion.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/02/24.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.218180, longitude: 72.834450), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    }
    
    static func regionFromLandmark(_ landmark: Landmark) -> MKCoordinateRegion {
        MKCoordinateRegion(center: landmark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    }
}

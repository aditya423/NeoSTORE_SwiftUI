//
//  LocationManager.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 09/02/24.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion.defaultRegion()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

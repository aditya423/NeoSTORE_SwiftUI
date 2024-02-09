//
//  LocationManager.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 09/02/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print ("Location access restricted")
        case .denied:
            print ("Location access denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print ("Location")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error.localizedDescription)
    }
}

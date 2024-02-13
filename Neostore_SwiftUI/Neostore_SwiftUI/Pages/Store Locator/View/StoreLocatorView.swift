//
//  StoreLocatorView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI
import MapKit

struct StoreLocatorView: View {
    
    // VARIABLES
    @State private var search: String = ""
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    
    // VIEW
    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    locationSearchVM.search(query: search)
                }
                .padding()
            
            if !locationSearchVM.landmarks.isEmpty {
                LandmarkListView()
            }
            
            Map(coordinateRegion: $locationSearchVM.region, showsUserLocation: true, annotationItems: locationSearchVM.landmarks) { landmark in
                MapMarker(coordinate: landmark.coordinate, tint: locationSearchVM.landmark==landmark ? .red : .green)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct StoreLocatorView_Previews: PreviewProvider {
    static var previews: some View {
        StoreLocatorView()
    }
}

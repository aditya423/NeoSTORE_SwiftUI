//
//  StoreLocatorView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI
import MapKit

struct StoreLocatorView: View {
    
    @State private var search: String = ""
    @EnvironmentObject var localSearchService: LocalSearchService
    
    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    localSearchService.search(query: search)
                }
                .padding()
            
            if !localSearchService.landmarks.isEmpty {
                LandmarkListView()
            }
            
            Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: localSearchService.landmarks) { landmark in
                MapMarker(coordinate: landmark.coordinate, tint: localSearchService.landmark==landmark ? .red : .green)
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

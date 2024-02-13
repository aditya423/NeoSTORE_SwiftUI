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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // VIEW
    var body: some View {
        
        VStack(spacing: 0) {
            
            Color.red.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: ImageNames.backArrow.rawValue)
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                            .padding([.leading, .vertical], 15)
                            .padding(.trailing, 5)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                                locationSearchVM.landmarks.removeAll()
                            }
                        
                        TextField("Search", text: $search)
                            .textFieldStyle(.roundedBorder)
                            .padding([.trailing, .vertical], 15)
                            .onSubmit {
                                locationSearchVM.search(query: search)
                            }
                    }
                    .background(.red)
                    
                    if !locationSearchVM.landmarks.isEmpty {
                        LandmarkListView()
                            .padding(.top, -10)
                    }
                    
                    Map(coordinateRegion: $locationSearchVM.region, showsUserLocation: true, annotationItems: locationSearchVM.landmarks) { landmark in
                        MapMarker(coordinate: landmark.coordinate, tint: locationSearchVM.landmark==landmark ? .red : .green)
                    }
                    .padding(.top, -10)
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct StoreLocatorView_Previews: PreviewProvider {
    static var previews: some View {
        StoreLocatorView()
    }
}

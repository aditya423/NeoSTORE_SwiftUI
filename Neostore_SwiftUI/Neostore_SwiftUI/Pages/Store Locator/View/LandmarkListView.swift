//
//  LandmarkListView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/02/24.
//

import SwiftUI
import MapKit

struct LandmarkListView: View {
    
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    
    var body: some View {
        VStack {
            List(locationSearchVM.landmarks) { landmark in
                VStack(alignment: .leading) {
                    Text(landmark.name)
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                    Text(landmark.title)
                        .opacity(0.5)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 15)
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(AppColors.grayColor)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .listRowBackground(locationSearchVM.landmark==landmark ? AppColors.grayColor : Color.white)
                .onTapGesture {
                    locationSearchVM.landmark = landmark
                    withAnimation {
                        locationSearchVM.region = MKCoordinateRegion.regionFromLandmark(landmark)
                    }
                }
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView()
    }
}

//
//  HomeView.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/5/22.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noImput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack (alignment: .top){
                MapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                }else if mapState == .noImput{
                    LocationSearchActionView()
                        .padding(.top, 72)
                        .onTapGesture {
                            mapState = .searchingForLocation
                        }
                }
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading)
            }
            if mapState == .locationSelected || mapState == .polyLineAdded{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }.edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location = location {
                    locationViewModel.userLocation = location
                }
                    
            }
        
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

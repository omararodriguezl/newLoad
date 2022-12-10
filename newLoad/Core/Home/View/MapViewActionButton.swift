//
//  MapViewActionButton.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/5/22.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        Button {
            withAnimation(.spring()){
                actionForState(mapState)
            }
        }label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    func actionForState (_ state: MapViewState){
        switch state {
        case .noImput:
            print("DEBUG: No input")
        case .searchingForLocation:
            mapState = .noImput
        case .locationSelected, .polyLineAdded:
            mapState = .noImput
            viewModel.selectedNewLoadLocationCoordinate = nil
            
        }
    }
    func imageNameForState (_ state: MapViewState) -> String{
        switch state {
        case .noImput:
           return "line.3.horizontal"
        case .searchingForLocation,  .locationSelected , .polyLineAdded:
           return "arrow.left"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noImput))
    }
}

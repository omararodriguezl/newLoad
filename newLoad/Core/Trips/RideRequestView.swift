//
//  RideRequestView.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/8/22.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .pickUp
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            //trip info view
            HStack{
                VStack{
                    Circle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                VStack (alignment: .leading, spacing: 24){
                    HStack{
                        Text("Current Location")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                        Text(locationViewModel.pickupTime ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    HStack{
                        if let location = locationViewModel.selectedNewLoadLocationCoordinate{
                            Text(location.title)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
            }.padding()
            Divider()
            // ride type selection view
            Text("SUGGESTED RIDES")
                .font (.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal){
                HStack(spacing: 12) {
                    ForEach(RideType.allCases){ type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65,height: 65)
                            VStack(spacing: 4){
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(locationViewModel.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(8)
                                
                        }
                        .frame(width: 112, height: 140)
                        .foregroundColor(type == selectedRideType ? .white: Color.theme.primaryTextColor)
                        .background(type == selectedRideType ? .blue: Color.theme.secondaryBackgrounColor)
                        .scaleEffect(type == selectedRideType ? 1.2: 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            Divider()
                .padding(.vertical, 8)
            //payment option view
            HStack(spacing: 12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                Text("**** 1234")
                    .fontWeight(.bold)
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgrounColor)
            .cornerRadius(10)
            .padding(.horizontal)
            //request ride button
            Button {
                
            } label: {
                Text("Confirm Ride")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

        }
        .padding(.bottom, 24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(12)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}

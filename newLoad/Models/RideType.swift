//
//  RideType.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/8/22.
//

import Foundation

enum RideType:Int, CaseIterable, Identifiable {
    case pickUp
    case smallTruck
    case truck
    
    var id: Int {return rawValue}
    
    var description : String {
        switch self {
        case .pickUp: return "Pick Up"
        case .smallTruck: return "Small Truck"
        case .truck: return "Truck"
        }
    }
    var imageName: String {
        switch self {
        case .pickUp: return "pickup"
        case .smallTruck: return "smalltruck"
        case .truck: return "truck"
        }
    }
    var baseFare: Double {
        switch self {
        case .pickUp: return 5
        case.smallTruck: return 10
        case.truck: return 20
        }
    }
    func computePrice (for distanceInMeters: Double) -> Double {
        let distanceInMile = distanceInMeters / 1600
        
        switch self{
        case .pickUp: return distanceInMile * 1.5 + baseFare
        case .smallTruck: return distanceInMile * 1.75 + baseFare
        case .truck: return distanceInMile * 2 + baseFare
        }
    }
}

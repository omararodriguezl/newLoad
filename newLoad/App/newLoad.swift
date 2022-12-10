//
//  servicesForYourBFApp.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/5/22.
//

import SwiftUI

@main
struct servicesForYourBFApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}

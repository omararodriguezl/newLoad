//
//  LocationSearchViewModel.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/5/22.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject  {
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectedNewLoadLocationCoordinate: newLoadLocation?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryfragment: String = "" {
        didSet{
            searchCompleter.queryFragment = queryfragment
        }
    }
    var userLocation: CLLocationCoordinate2D?
    override init(){
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryfragment
    }
    func selectLocation (_ location: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: location) { response, error in
            if let error = error {
                print ("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedNewLoadLocationCoordinate = newLoadLocation(title: location.title, coordinate: coordinate)
            print ("DEBUG: Location coordinates \(coordinate)")
        }
    }
    func locationSearch (forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    func computeRidePrice (forType type: RideType) -> Double {
        guard let destCoordinate = selectedNewLoadLocationCoordinate?.coordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else {return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            if let error = error {
                print ("DEBUG: Failed to get direction with error \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else {return}
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    func configurePickupAndDropoffTimes(with expectiedTravelTime: Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectiedTravelTime)
    }
}
extension LocationSearchViewModel:MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}

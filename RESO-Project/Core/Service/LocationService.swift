//
//  LocationService.swift
//  RESO-Project
//
//  Created by Andrey on 07.05.2022.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    static let shared = LocationService()
    private override init(){}
    private (set) var currentLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    
    func requestAuthorization() {
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        } else {
            print("Пожалуйста, включите вервис GPS")
        }
    }
    
    func getDistance(lat: Double, lon: Double) -> Double? {
        let targerLocation = CLLocation(latitude: lat, longitude: lon)
        guard let userLocation = self.currentLocation else { return nil }
        let distance = targerLocation.distance(from: userLocation)
        return distance
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locationManager.location
    }
}

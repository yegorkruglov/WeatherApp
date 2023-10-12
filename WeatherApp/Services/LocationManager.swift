//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 09.10.2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    var isAuthorizedLocation: Bool?
    
    public var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        self.locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        switch status {
            
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            self.isAuthorizedLocation = true
        case .restricted, .denied:
            self.isAuthorizedLocation = false
            
        @unknown default:
            print("error")
        }
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "isLocationChanged"),
            object: nil
        )
    }
}

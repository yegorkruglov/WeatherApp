//
//  CurentLocationViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 09.10.2023.
//

import Foundation
import CoreLocation

protocol CurentLocationViewModelProtocol {
    func fetchWeatherForLocation(completion: @escaping() -> Void)
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
}

final class CurentLocationViewModel: NSObject, CurentLocationViewModelProtocol {
    private let networkManager = NetworkManager.shared

    private let locationManager = CLLocationManager()
    
    private var currentCoordinates: CLLocationCoordinate2D? {
        didSet {
            requestWeatherForCurrentlocation()
        }
    }
    
    private var weatherData: Weather?

    func fetchWeatherForLocation(completion: @escaping() -> Void) {
        
        
        completion()
    }
    
    func numberOfSections() -> Int { 4 }
    
    func numberOfRowsInSection() -> Int { 1 }
    
    
    
    
    
    func requestCurrentLocation() {
        locationManager.requestLocation()
    }
    
    func requestWeatherForCurrentlocation() {
        guard (currentCoordinates != nil) else {
            print("No location -> no weather")
            return
        }
        
        networkManager.requestWeatherFor(
            latitude: currentCoordinates?.latitude,
            longitude: currentCoordinates?.longitude
        ) { result in
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func checkLocationManagerAutharizationStatus() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined, .restricted, .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse: break
        @unknown default:
            locationManager.requestWhenInUseAuthorization()
        }
        
        requestCurrentLocation()
    }
}

extension CurentLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentCoordinates = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        checkLocationManagerAutharizationStatus()
    }
}

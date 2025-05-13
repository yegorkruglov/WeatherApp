//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import Foundation
import Combine
import CoreLocation

final class WeatherInfoViewModel: NSObject {
    
    // MARK: - private properties
    
    private let api: ApiProtocol
    private let locationManger: CLLocationManager
    
    // MARK: - publishers
    
    private var cancellables: Set<AnyCancellable> = []
    private var statePublisher = PassthroughSubject<WeatherInfoViewController.State, Never>()
    
    // MARK: -  initilizers
    
    init(dependencies: Dependencies) {
        self.api = dependencies.resolve()
        self.locationManger = dependencies.resolve()
    }
    
    // MARK: - public methods
    
    func bind(_ input: Input) -> Output {
        
        setupLocationManager()
        checkLocationAuthorizationStatus()
        
        return Output()
    }
}

// MARK: - private methods

private extension WeatherInfoViewModel {
    
    func setupLocationManager() {
        locationManger.delegate = self
    }
    
    func checkLocationAuthorizationStatus() {
        switch locationManger.authorizationStatus {
            
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManger.requestLocation()
            
        default:
            break
            //get weather for moscow
            //show alert to acces auth status??
        }
    }
    
    func getWeatherForLocation(latitude: Double, longitude: Double) {
        api.getWeatherInfoForLocation(lat: latitude, long: longitude)
            .sink { result in
                switch result {
                    
                case .finished:
                    print("Finished fetching weather")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    //show error
                }
                
            } receiveValue: { weatherInfo in
                print(weatherInfo)
            }
            .store(in: &cancellables)

    }
}

extension WeatherInfoViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
            
        default:
            break
            //show alert to acces auth status??
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        getWeatherForLocation(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}

// MARK: - entities

extension WeatherInfoViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
}

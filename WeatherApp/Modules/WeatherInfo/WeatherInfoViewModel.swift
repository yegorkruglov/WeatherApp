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
    private let defaultCorrdinate = CLLocationCoordinate2D(latitude: 55.752222, longitude: 37.615556)
    
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
        
        handleReloadButtonPublisher(input.errorReloadButtonPublisher)
        handleReloadButtonPublisher(input.reloadButtonPublisher)
        
        return Output(
            statePublisher: statePublisher.eraseToAnyPublisher()
        )
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
            getWeatherForLocation(
                latitude: defaultCorrdinate.latitude,
                longitude: defaultCorrdinate.longitude
            )
            statePublisher.send(.locationAuthRequiredAlert)
        }
    }
    
    func getWeatherForLocation(latitude: Double, longitude: Double) {
        api.getWeatherInfoForLocation(lat: latitude, long: longitude)
            .sink { [weak self] result in
                switch result {
                    
                case .finished:
                    print("Finished fetching weather")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.statePublisher.send(.error(error))
                }
                
            } receiveValue: { [weak self] weatherInfo in
                print(weatherInfo)
                self?.statePublisher.send(.loaded(weatherInfo))
            }
            .store(in: &cancellables)
    }
    
    func handleReloadButtonPublisher(_ publisher: AnyPublisher<Void, Never>) {
        publisher
            .sink { [weak self] _ in
                self?.statePublisher.send(.loading)
                self?.locationManger.requestLocation()
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
            statePublisher.send(.locationAuthRequiredAlert)
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
        statePublisher.send(.error(error))
    }
}

// MARK: - entities

extension WeatherInfoViewModel {
    
    struct Input {
        let errorReloadButtonPublisher: AnyPublisher<Void, Never>
        let reloadButtonPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let statePublisher: AnyPublisher<WeatherInfoViewController.State, Never>
    }
}

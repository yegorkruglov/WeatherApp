//
//  LocationsViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import Foundation
import CoreLocation

protocol LocationsViewControllerViewModelProtocol {
    var CurrentLocationWeatherData: Bindable<Weather?> { get }
    
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol
    
    func getHeaderTitleForSection(number: Int) -> String
//    func fetchWeatherForLocationCurrentLocation() -> Weather
//    func fetchWeatherForLocation(at indexPath: IndexPath) -> Weather
}

final class LocationsViewControllerViewModel: LocationsViewControllerViewModelProtocol {
    private let networkManager = NetworkManager.shared
    private let locationManager = LocationManager()
    
    private(set) var CurrentLocationWeatherData = Bindable<Weather?> (value: nil)
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkLocation),
            name: Notification.Name(rawValue: "isLocationChanged"),
            object: nil
        )
        
        checkLocation()
    }
    
    func getNumberOfSections() -> Int {
        LocationsTable.allCases.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        switch section {
        case LocationsTable.CurrentLocation.rawValue: 1
        case LocationsTable.Other.rawValue: 0
        default:
            0
        }
    }
    
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol {
        SummaryCellViewModel(weatherData: weatherData)
    }
    
    func getHeaderTitleForSection(number: Int) -> String {
        LocationsTable.allCases[number].value
    }
    
//    func fetchWeatherForLocationCurrentLocation() -> Weather {
//        <#code#>
//    }
//    
//    func fetchWeatherForLocation(at indexPath: IndexPath) -> Weather {
//        <#code#>
//    }
    
    
    
    
    
    
    
    
    
    @objc  func checkLocation() {
        guard let isAuthorizedLocation = locationManager.isAuthorizedLocation else { return }
        
        if isAuthorizedLocation {
            let coordinates = getLocationCoordinates()
            fetchWeatherForLocation(
                lat: coordinates.coordinate.latitude,
                long: coordinates.coordinate.longitude
            )
        }
    }
    
    func getLocationCoordinates() -> CLLocation {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            return CLLocation(latitude: 0.0, longitude: 0.0)
        }
        
        return exposedLocation
    }
    
    func fetchWeatherForLocation(lat: CLLocationDegrees, long: CLLocationDegrees) {
        networkManager.requestWeatherFor(latitude: lat, longitude: long) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.CurrentLocationWeatherData.value = weatherData
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

enum LocationsTable: Int, CaseIterable {
    case CurrentLocation
    case Other
    
    var value: String {
        switch self {
        case .CurrentLocation:
            "Current location"
        case .Other:
            "Other"
        }
    }
}


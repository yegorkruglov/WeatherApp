//
//  LocationsViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import Foundation
import CoreLocation
import RealmSwift

protocol LocationsViewControllerViewModelProtocol {
    var currentLocationWeatherData: Bindable<Weather?> { get }
    var savedLocations: Results<LocationRealm> { get }
    var savedLocationsWeatherData: Bindable<[Weather]> { get }
    
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(number: Int) -> Int
    
    func getSummaryCellViewModel(at indexPath: IndexPath) -> SummaryCellViewModelProtocol?
    func getWeatherViewControllerViewModel(at indexPath: IndexPath) -> WeatherViewControllerViewModelProtocol?
    func getHeaderTitleForSection(number: Int) -> String
    func updateTableView()
}

final class LocationsViewControllerViewModel: LocationsViewControllerViewModelProtocol {
    
    private let networkManager = NetworkManager.shared
    
    private let locationManager = LocationManager()
    
    private let storageManager = StorageManager.shared
    
    private(set) var currentLocationWeatherData = Bindable<Weather?> (value: nil)
    
    private(set) var savedLocations: Results<LocationRealm>
    
    private(set) lazy var savedLocationsWeatherData = Bindable<[Weather]> (value: [])
        
    init() {
        savedLocations = storageManager.realm.objects(LocationRealm.self)
        getSavedLocationsWeatherData()
        
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
    
    func getNumberOfRowsInSection(number: Int) -> Int {
        switch number {
        case LocationsTable.CurrentLocation.rawValue: 1
        case LocationsTable.Other.rawValue: savedLocations.count
        default:
            0
        }
    }
        
    func getSummaryCellViewModel(at indexPath: IndexPath) -> SummaryCellViewModelProtocol? {
        switch indexPath.section {
        
        case LocationsTable.CurrentLocation.rawValue:
            guard let weatherData = currentLocationWeatherData.value else { return nil }
            return SummaryCellViewModel(weatherData: weatherData)
        default:
            let weatherData = savedLocationsWeatherData.value[indexPath.row]
            return SummaryCellViewModel(weatherData: weatherData)
        }
    }

    func getWeatherViewControllerViewModel(at indexPath: IndexPath) -> WeatherViewControllerViewModelProtocol? {
        switch indexPath.section {
        
        case LocationsTable.CurrentLocation.rawValue:
            guard let weatherData = currentLocationWeatherData.value else { return nil }
            return WeatherViewControllerViewModel(
                weatherData: weatherData,
                isCurrentLocationViewController: true
            )
        default:
            let weatherData = savedLocationsWeatherData.value[indexPath.row]
            return WeatherViewControllerViewModel(
                weatherData: weatherData,
                isCurrentLocationViewController: false
            )
        }
    }

    func getHeaderTitleForSection(number: Int) -> String {
        LocationsTable.allCases[number].value
    }

    func updateTableView() {
        savedLocations = getSavedLocations()
        getSavedLocationsWeatherData()
    }
    
    func getSavedLocations() -> Results<LocationRealm> {
        return storageManager.realm.objects(LocationRealm.self)
    }
    
    func getSavedLocationsWeatherData() {
        savedLocationsWeatherData.value = []
        
        guard !savedLocations.isEmpty else { return }
        savedLocations.forEach { location in
            networkManager.requestWeatherFor(
                latitude: location.latitude,
                longitude: location.longitude
            ) { [weak self] result in
                switch result {
                case .success(let weatherResponse):
                    self?.savedLocationsWeatherData.value.append(weatherResponse)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
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
        networkManager.requestWeatherFor(latitude: lat, longitude: long) { [unowned self] result in
            switch result {
            case .success(let weatherData):
                self.currentLocationWeatherData.value = weatherData
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


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
    var savedLocations: Results<LocationRealm>! { get }
    var savedLocationsWeatherData: Bindable<[Weather]?> { get }
    
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol
    
    func getHeaderTitleForSection(number: Int) -> String
    
    func updateTableView()
}

final class LocationsViewControllerViewModel: LocationsViewControllerViewModelProtocol {
    
    private let networkManager = NetworkManager.shared
    
    private let locationManager = LocationManager()
    
    private let storageManager = StorageManager.shared
    
    private(set) var currentLocationWeatherData = Bindable<Weather?> (value: nil)
    
    private(set) var savedLocations: RealmSwift.Results<LocationRealm>!
    
    private(set) var savedLocationsWeatherData = Bindable<[Weather]?> (value: [])
    
    init() {
        getSavedLocations()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkLocation),
            name: Notification.Name(rawValue: "isLocationChanged"),
            object: nil
        )
        
        checkLocation()
    }
    
    func updateTableView() {
        getSavedLocations()
    }
    
    func getNumberOfSections() -> Int {
        LocationsTable.allCases.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        switch section {
        case LocationsTable.CurrentLocation.rawValue: 1
        case LocationsTable.Other.rawValue: savedLocations.count
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
    
    func getSavedLocations() {
       savedLocations = storageManager.realm.objects(LocationRealm.self)
               
        guard !savedLocations.isEmpty else { return }
        savedLocations.forEach { location in
            networkManager.requestWeatherFor(
                latitude: location.latitude,
                longitude: location.longitude
            ) { [weak self] result in
                switch result {
                case .success(let weatherResponse):
                    self?.savedLocationsWeatherData.value?.append(weatherResponse)
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
        networkManager.requestWeatherFor(latitude: lat, longitude: long) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.currentLocationWeatherData.value = weatherData
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


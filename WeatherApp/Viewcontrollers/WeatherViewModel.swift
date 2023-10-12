//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 09.10.2023.
//

import Foundation
import CoreLocation

protocol WeatherViewModelProtocol {
    var weatherData: Bindable<Weather?> { get }
    
    func numberOfSections() -> Int
    func numberOfRowsIn(section: Int) -> Int
    
    func getHeaderTitle(forSection number: Int) -> String
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol
    func getHourlyCellViewModel(withWeather weatherData: Weather) -> HourlyCollectionViewViewModelProtocol
    func getExtraCellViewModel(withWeather weatherdata: Weather) -> ExtraCollectionViewModelProtocol
    func getDailySectionCellViewModel(withDay forecastDay: Forecastday) -> DailyCellViewModelProtocol
}

final class WeatherViewModel: WeatherViewModelProtocol {    
    private let networkManager = NetworkManager.shared
    private let locationManager = LocationManager()
    
    private(set) var weatherData = Bindable<Weather?> (value: nil)
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkLocation),
            name: Notification.Name(rawValue: "isLocationChanged"),
            object: nil
        )
        
        checkLocation()
    }
    
    @objc private func checkLocation() {
        guard let isAuthorizedLocation = locationManager.isAuthorizedLocation else { return }
        
        if isAuthorizedLocation {
            let coordinates = getLocationCoordinates()
            requestWeatherForLocation(
                lat: coordinates.coordinate.latitude,
                long: coordinates.coordinate.longitude
            )
        }
    }
    
    private func getLocationCoordinates() -> CLLocation {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            return CLLocation(latitude: 0.0, longitude: 0.0)
        }
        
        return exposedLocation
    }
    
    private func requestWeatherForLocation(
        lat: CLLocationDegrees,
        long: CLLocationDegrees
    ) {
        networkManager.requestWeatherFor(
            latitude: lat,
            longitude: long
        ) { result in
            switch result {
            case .success(let weatherData):
                self.weatherData.value = weatherData
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func numberOfSections() -> Int { Table.allCases.count }
    
    func numberOfRowsIn(section: Int) -> Int {
        switch section {
        case Table.Daily.rawValue: weatherData.value?.forecast.forecastday.count ?? 0
        default: 1
        }
    }
    
    func getHeaderTitle(forSection number: Int) -> String {
        Table.allCases[number].value
    }
    
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol {
       SummaryCellViewModel(weatherData: weatherData)
    }
    
    func getHourlyCellViewModel(withWeather weatherData: Weather) -> HourlyCollectionViewViewModelProtocol {
        HourlyCollectionViewViewModel(weatherData: weatherData)
    }
    
    func getExtraCellViewModel(withWeather weatherdata: Weather) -> ExtraCollectionViewModelProtocol {
        ExtraCollectionViewViewmodel(weatherData: weatherdata)
    }
    
    func getDailySectionCellViewModel(withDay forecastDay: Forecastday) -> DailyCellViewModelProtocol {
        DailyCellViewModel(forecastDay: forecastDay)
    }
    
}

enum Table: Int, CaseIterable {
    case Summary
    case Hourly
    case Extra
    case Daily
    
    var value: String {
        switch self {
        case .Summary:
            "Summary"
        case .Hourly:
            "Hourly forecast"
        case .Extra:
            "Extra details"
        case .Daily:
            "Daily forecast"
        }
    }
}
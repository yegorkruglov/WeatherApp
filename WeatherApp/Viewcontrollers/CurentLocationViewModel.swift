//
//  CurentLocationViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 09.10.2023.
//

import Foundation
import CoreLocation

protocol CurentLocationViewModelProtocol {
    var weatherData: Bindable<Weather?> { get }
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol
    func getHourlyCellViewModel(withWeather weatherData: Weather) -> HourlyCellViewModelProtocol
}

final class CurentLocationViewModel: CurentLocationViewModelProtocol {
    
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
                print(self.weatherData.value?.current.condition.text)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func numberOfSections() -> Int { Table.allCases.count }
    
    func numberOfRowsInSection() -> Int { 1 }
    
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol {
        SummaryCellViewModel(weatherData: weatherData)
    }
    
    func getHourlyCellViewModel(withWeather weatherData: Weather) -> HourlyCellViewModelProtocol {
        HourlyCellViewModel(weatherData: weatherData)
    }
    
}

//MARK: - UITableView Configuration

enum Table: Int, CaseIterable {
    case Summary
    case Hourly
    case Extra
    case Daily
}

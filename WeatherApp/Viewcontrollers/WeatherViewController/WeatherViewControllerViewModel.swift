//
//  WeatherViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 09.10.2023.
//

import Foundation

protocol WeatherViewControllerViewModelProtocol {
    var weatherData: Weather { get }
    var isCurrentLocationViewController: Bool { get }
    var isFavourite: Bindable<Bool> { get }
    
    init(weatherData: Weather, isCurrentLocationViewController: Bool)
    
    func numberOfSections() -> Int
    func numberOfRowsIn(section: Int) -> Int
    
    func getHeaderTitle(forSection number: Int) -> String
    func getSummaryCellViewModel() -> SummaryCellViewModelProtocol
    func getHourlyCellViewModel() -> HourlyCollectionViewViewModelProtocol
    func getExtraCellViewModel() -> ExtraCollectionViewModelProtocol
    func getDailySectionCellViewModel(at indexPath: IndexPath) -> DailyCellViewModelProtocol
    
    func manageLocation()
}

final class WeatherViewControllerViewModel: WeatherViewControllerViewModelProtocol {
    private let networkManager = NetworkManager.shared
    
    private let storageManager = StorageManager.shared
    
    let weatherData: Weather
    
    let isCurrentLocationViewController: Bool
    
    let isFavourite = Bindable<Bool> (value: false)
    
    init(weatherData: Weather, isCurrentLocationViewController: Bool) {
        self.weatherData = weatherData
        self.isCurrentLocationViewController = isCurrentLocationViewController
        isFavourite.value = setFavouriteStatus()
    }
    
    func numberOfSections() -> Int { WeatherTable.allCases.count }
    
    func numberOfRowsIn(section: Int) -> Int {
        switch section {
        case WeatherTable.Daily.rawValue: weatherData.forecast.forecastday.count
        default: 1
        }
    }
    
    func getHeaderTitle(forSection number: Int) -> String {
        WeatherTable.allCases[number].value
    }
    
    func getSummaryCellViewModel() -> SummaryCellViewModelProtocol {
        SummaryCellViewModel(weatherData: weatherData)
    }
    
    func getHourlyCellViewModel() -> HourlyCollectionViewViewModelProtocol {
        HourlyCollectionViewViewModel(weatherData: weatherData)
    }
    
    func getExtraCellViewModel() -> ExtraCollectionViewModelProtocol {
        ExtraCollectionViewViewmodel(weatherData: weatherData)
    }
    
    func getDailySectionCellViewModel(at indexPath: IndexPath) -> DailyCellViewModelProtocol {
        DailyCellViewModel(forecastDay: weatherData.forecast.forecastday[indexPath.row])
    }
    
    func manageLocation() {
        let location = weatherData.location
        
        if isFavourite.value {
            storageManager.delete(location)
            print("deleted")
            isFavourite.value.toggle()
        } else {
            storageManager.save(location) { _ in
                print("saved")
                isFavourite.value.toggle()
            }
        }
    }
    
    func setFavouriteStatus() -> Bool {
        storageManager.realm.objects(LocationRealm.self).contains { savedLocation in
            weatherData.location.lat == savedLocation.latitude
            && weatherData.location.lon == savedLocation.longitude
        }
    }
}

enum WeatherTable: Int, CaseIterable {
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

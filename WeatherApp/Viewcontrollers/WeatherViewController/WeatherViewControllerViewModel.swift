//
//  WeatherViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 09.10.2023.
//

import Foundation

protocol WeatherViewControllerViewModelProtocol {
    var weatherData: Bindable<Weather?> { get }
    
    init(weatherData: Weather)
    
    func numberOfSections() -> Int
    func numberOfRowsIn(section: Int) -> Int
    
    func getHeaderTitle(forSection number: Int) -> String
    func getSummaryCellViewModel(withWeather weatherData: Weather) -> SummaryCellViewModelProtocol
    func getHourlyCellViewModel(withWeather weatherData: Weather) -> HourlyCollectionViewViewModelProtocol
    func getExtraCellViewModel(withWeather weatherdata: Weather) -> ExtraCollectionViewModelProtocol
    func getDailySectionCellViewModel(withDay forecastDay: Forecastday) -> DailyCellViewModelProtocol
}

final class WeatherViewControllerViewModel: WeatherViewControllerViewModelProtocol {
    private let networkManager = NetworkManager.shared
    
    private(set) var weatherData = Bindable<Weather?> (value: nil)
    
    init(weatherData: Weather) {
        self.weatherData.value = weatherData
    }
    
    func numberOfSections() -> Int { WeatherTable.allCases.count }
    
    func numberOfRowsIn(section: Int) -> Int {
        switch section {
        case WeatherTable.Daily.rawValue: weatherData.value?.forecast.forecastday.count ?? 0
        default: 1
        }
    }
    
    func getHeaderTitle(forSection number: Int) -> String {
        WeatherTable.allCases[number].value
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

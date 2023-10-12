//
//  SummarySectionViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol SummarySectionViewModelProtocol {
    var locationName: String { get }
    var conditionText: String { get }
    var currentTempText: String { get }
    var highestTempText: String { get }
    var lowestTempText: String { get }
    var conditionImageURL: URL? { get }
    
    init(weatherData: Weather)
}

class SummarySectionViewModel: SummarySectionViewModelProtocol {
    var locationName: String { weatherData.location.name }
    
    var conditionText: String { weatherData.current.condition.text }
    
    var currentTempText: String { "t: " + String(Int(weatherData.current.tempC)) + "°" }
    
    var highestTempText: String {
        guard let maxTemp = weatherData.forecast.forecastday.first?.day.maxtempC else { return "err"}
        return "H: " + String(Int(maxTemp)) + "°"
    }
    
    var lowestTempText: String {
        guard let minTemp = weatherData.forecast.forecastday.first?.day.mintempC else { return "err"}
        return "L: " + String(Int(minTemp)) + "°"
    }
    
    var conditionImageURL: URL? { getConditionImageURL() }
    
    private let weatherData: Weather
    
    required init(weatherData: Weather) {
        self.weatherData = weatherData
    }
    
    private func getConditionImageURL() -> URL? {
        guard let url = URL(string: "https:" + weatherData.current.condition.icon) else { return nil}
        return url
    }
}

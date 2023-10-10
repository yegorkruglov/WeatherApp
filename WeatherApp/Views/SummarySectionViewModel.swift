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
    
    init(weatherData: Weather)
}

class SummarySectionViewModel: SummarySectionViewModelProtocol {
    var locationName: String { weatherData.location.name }
    
    var conditionText: String { weatherData.current.condition.text }
    
    var currentTempText: String { String(weatherData.current.tempC) }
    
    var highestTempText: String {
        guard let maxTemp = weatherData.forecast.forecastday.first?.day.maxtempC else { return "err"}
        return String(maxTemp)
    }
    
    var lowestTempText: String {
        guard let minTemp = weatherData.forecast.forecastday.first?.day.mintempC else { return "err"}
        return String(minTemp)
    }
    
    private let weatherData: Weather
    
    required init(weatherData: Weather) {
        self.weatherData = weatherData
    }
}

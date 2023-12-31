//
//  SummaryCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol SummaryCellViewModelProtocol {
    var locationName: String { get }
    var conditionText: String { get }
    var currentTempText: String { get }
    var highestTempText: String { get }
    var lowestTempText: String { get }
    var conditionImageURL: URL? { get }
    
    init(weatherData: Weather)
}

final class SummaryCellViewModel: SummaryCellViewModelProtocol {
    var locationName: String { weatherData.location.name }
    
    var conditionText: String { weatherData.current.condition.text }
    
    var currentTempText: String { String(Int(weatherData.current.tempC)) + "°" }
    
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
}

extension SummaryCellViewModel {
    private func getConditionImageURL() -> URL? {
        guard weatherData.current.condition.icon != "" else { return nil }
        guard let url = URL(string: "https:" + weatherData.current.condition.icon) else { return nil}
        return url
    }
}

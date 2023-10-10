//
//  HourlySectionViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol HourlySectionViewModelProtocol {
    init(weatherData: Weather)
}

class HourlySectionViewModel: HourlySectionViewModelProtocol {
    private let weatherData: Weather

    required init(weatherData: Weather) {
        self.weatherData = weatherData
    }
}

//
//  HourlyCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol HourlyCellViewModelProtocol {
    init(weatherData: Weather)
}

class HourlyCellViewModel: HourlyCellViewModelProtocol {
    private let weatherData: Weather

    required init(weatherData: Weather) {
        self.weatherData = weatherData
    }
}

//
//  HourlySectionViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol HourlySectionViewModelProtocol {
    init(weatherData: Weather)
    
    var weatherData: Bindable<Weather?> { get }
    func getHourlySectionCellViewModel(at indexPath: IndexPath) -> HourlySectionCellViewModel
    func getNumberOfItems() -> Int
}

class HourlySectionViewModel: HourlySectionViewModelProtocol {
    func getHourlySectionCellViewModel(at indexPath: IndexPath) -> HourlySectionCellViewModel {
        let hourData = hoursData[indexPath.item]
        return HourlySectionCellViewModel(hourData: hourData)
    }
    
    func getNumberOfItems() -> Int {
        hoursData.count
    }
    
    private var hoursData: [Hour] { weatherData.value?.forecast.forecastday.first?.hour ?? [] }
    
    private(set) var weatherData = Bindable<Weather?> (value: nil)

    required init(weatherData: Weather) {
        self.weatherData.value = weatherData
    }
}

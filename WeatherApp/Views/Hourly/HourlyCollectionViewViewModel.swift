//
//  HourlyCollectionViewViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol HourlyCollectionViewViewModelProtocol {
    init(weatherData: Weather)
    
    func getHourlySectionCellViewModel(at indexPath: IndexPath) -> HourlyCollectionViewCellViewModel
    func getNumberOfItems() -> Int
}

final class HourlyCollectionViewViewModel: HourlyCollectionViewViewModelProtocol {
    func getHourlySectionCellViewModel(at indexPath: IndexPath) -> HourlyCollectionViewCellViewModel {
        let hourData = hoursData[indexPath.item]
        return HourlyCollectionViewCellViewModel(hourData: hourData)
    }
    
    func getNumberOfItems() -> Int {
        hoursData.count
    }
    
    private var hoursData: [Hour] { getHoursData() }
    
    private(set) var weatherData: Weather

    required init(weatherData: Weather) {
        self.weatherData = weatherData
    }
}

extension HourlyCollectionViewViewModel {
    private func getHoursData() -> [Hour] {
        var hoursData: [Hour] = []
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let allDays = weatherData.forecast.forecastday
        
        var allHoursData = allDays.flatMap { $0.hour }
        allHoursData.removeAll { hour in
            guard let hourDate = dateFormatter.date(from: hour.time) else { return false }
            
            return hourDate < currentDate
        }
        
        for index in 0...11 {
            hoursData.append(allHoursData[index])
        }
        
        return hoursData
    }
}

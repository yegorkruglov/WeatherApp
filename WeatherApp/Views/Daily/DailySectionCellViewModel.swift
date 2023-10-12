//
//  DailySectionCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 12.10.2023.
//

import Foundation

protocol DailySectionCellViewModelProtocol {
    var dateText: String { get }
    var conditionText: String { get }
    var tempHighText: String { get }
    var tempLowText: String { get }
    
    init(forecastDay: Forecastday)
}

class DailySectionCellViewModel: DailySectionCellViewModelProtocol {
    var dateText: String { getFormattedDate() }
    
    var conditionText: String { forecastDay.day.condition.text }
    
    var tempHighText: String { "H: " + String(forecastDay.day.maxtempC) }
    
    var tempLowText: String { "L: " + String(forecastDay.day.mintempC) }
    
    
    private let forecastDay: Forecastday
    
    required init(forecastDay: Forecastday) {
        self.forecastDay = forecastDay
    }
    
    private func getFormattedDate() -> String {
           
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: forecastDay.date) else { return "err" }
        
        dateFormatter.dateFormat = "dd.MM"
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
}

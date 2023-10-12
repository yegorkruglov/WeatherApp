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
    var conditionImageURL: URL? { get }
    
    init(forecastDay: Forecastday)
}

class DailySectionCellViewModel: DailySectionCellViewModelProtocol {
    var dateText: String { getFormattedDate() }
    
    var conditionText: String { forecastDay.day.condition.text }
    
    var tempHighText: String { "H: " + String(Int(forecastDay.day.maxtempC.rounded())) + "°" }
    
    var tempLowText: String { "L: " + String(Int(forecastDay.day.mintempC.rounded())) + "°" }
    
    var conditionImageURL: URL? { getConditionImageURL() }
    
    
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
    
    private func getConditionImageURL() -> URL? {
        guard let url = URL(string: "https:" + forecastDay.day.condition.icon) else { return nil}
        return url
    }
    
}
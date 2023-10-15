//
//  DailyCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 12.10.2023.
//

import Foundation

protocol DailyCellViewModelProtocol {
    var dateText: String { get }
    var conditionText: String { get }
    var tempHighText: String { get }
    var tempLowText: String { get }
    var conditionImageURL: URL? { get }
    
    init(forecastDay: Forecastday)
}

final class DailyCellViewModel: DailyCellViewModelProtocol {
    var dateText: String { getFormattedDate() }
    
    var conditionText: String { forecastDay.day.condition.text }
    
    var tempHighText: String { "H: " + String(Int(forecastDay.day.maxtempC.rounded())) + "°" }
    
    var tempLowText: String { "L: " + String(Int(forecastDay.day.mintempC.rounded())) + "°" }
    
    var conditionImageURL: URL? { getConditionImageURL() }
    
    private let forecastDay: Forecastday
    
    required init(forecastDay: Forecastday) {
        self.forecastDay = forecastDay
    }
}

private extension DailyCellViewModel {
    func getFormattedDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: forecastDay.date) else { return "err" }
        
        dateFormatter.dateFormat = "dd.MM"
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func getConditionImageURL() -> URL? {
        guard forecastDay.day.condition.icon != "" else { return nil }
        guard let url = URL(string: "https:" + forecastDay.day.condition.icon) else { return nil }
        return url
    }
}

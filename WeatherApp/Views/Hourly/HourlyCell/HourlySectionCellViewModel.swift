//
//  HourlySectionCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol HourlySectionCellViewModelProtocol {
    var hourText: String { get }
    var tempText: String { get }
    var conditionImageURL: URL? { get }
    init(hourData: Hour)
}

class HourlySectionCellViewModel: HourlySectionCellViewModelProtocol {
    
    
    var hourText: String {  getFormattedHour(from: hourData.time) }
        
    var tempText: String { String(hourData.tempC) + "°" }
    
    var conditionImageURL: URL? { getConditionImageURL() }
        
    private let hourData: Hour
    
    required init(hourData: Hour) {
        self.hourData = hourData
    }
    
    private func getFormattedHour(from dateText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from: dateText)  else { return "err"}
        
        dateFormatter.dateFormat = "HH"
        let hourString = dateFormatter.string(from: date)
        
        return hourString
    }
    
    private func getConditionImageURL() -> URL? {
        guard let url = URL(string: "https:" + hourData.condition.icon) else { return nil}
        return url
    }
}

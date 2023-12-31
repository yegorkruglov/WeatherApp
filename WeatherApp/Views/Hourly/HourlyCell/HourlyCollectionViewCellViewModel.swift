//
//  HourlyCollectionViewCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation

protocol HourlyCollectionViewCellViewModelProtocol {
    var hourText: String { get }
    var tempText: String { get }
    var conditionImageURL: URL? { get }
    
    init(hourData: Hour)
}

final class HourlyCollectionViewCellViewModel: HourlyCollectionViewCellViewModelProtocol {
    
    var hourText: String {  getFormattedHour(from: hourData.time) }
    
    var tempText: String { String(Int(hourData.tempC)) + "°" }
    
    var conditionImageURL: URL? { getConditionImageURL() }
    
    private let hourData: Hour
    
    required init(hourData: Hour) {
        self.hourData = hourData
    }
}

private extension HourlyCollectionViewCellViewModel {
    func getFormattedHour(from dateText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from: dateText)  else { return "err"}
        
        dateFormatter.dateFormat = "HH"
        let hourString = dateFormatter.string(from: date)
        
        return hourString
    }
    
    func getConditionImageURL() -> URL? {
        guard hourData.condition.icon != "" else { return nil }
        guard let url = URL(string: "https:" + hourData.condition.icon) else { return nil}
        return url
    }
}

//
//  HourlySectionCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import Foundation


protocol HourlySectionCellViewModelProtocol {
    var hourText: String { get }
    var conditionText: String { get }
    var tempText: String { get }
    
    init(hourData: Hour)
}

class HourlySectionCellViewModel: HourlySectionCellViewModelProtocol {
    var hourText: String { hourData.time }
    
    var conditionText: String { hourData.condition.text }
    
    var tempText: String { String(hourData.tempC) }
    
    private let hourData: Hour
    
    required init(hourData: Hour) {
        self.hourData = hourData
    }
}

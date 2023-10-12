//
//  ExtraSectionCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 12.10.2023.
//

import Foundation

protocol ExtraSectionCellViewModelProtocol {
    var cellName: String { get }
    var cellValue: String { get }
    
    init(cellName: String, cellValue: String)
}

class ExtraSectionCellViewModel: ExtraSectionCellViewModelProtocol {
    
    var cellName: String
    
    var cellValue: String
    
    required init(cellName: String, cellValue: String) {
        self.cellName = cellName
        self.cellValue = cellValue
    }
    
}

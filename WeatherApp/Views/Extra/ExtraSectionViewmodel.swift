//
//  ExtraSectionViewmodel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 12.10.2023.
//

import Foundation

protocol ExtraSectionViewModelProtocol {
    init(weatherData: Weather)
    
    var weatherData: Bindable<Weather?> { get }
    
    func getNumberOfItems() -> Int
    
    func getExtraSectionCellViewModel(at indexPath: IndexPath) -> ExtraSectionCellViewModel
}

class ExtraSectionViewmodel: ExtraSectionViewModelProtocol {
    
    private(set) var weatherData = Bindable<Weather?> (value: nil)

    func getNumberOfItems() -> Int {
        8
    }
    
    func getExtraSectionCellViewModel(at indexPath: IndexPath) -> ExtraSectionCellViewModel {
        switch indexPath.row {
        case 0:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        case 1:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        case 2:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        case 3:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        case 4:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        case 5:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        case 6:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        default:
            ExtraSectionCellViewModel(cellName: "", cellValue: "")
        }
    }
    
    required init(weatherData: Weather) {
        self.weatherData.value = weatherData
    }
    
    
    
    
}

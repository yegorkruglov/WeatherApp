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
        Extra.allCases.count
    }
    
    func getExtraSectionCellViewModel(at indexPath: IndexPath) -> ExtraSectionCellViewModel {
        switch indexPath.row {
        case Extra.FeelsLike.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.FeelsLike.text,
                cellValue: String(Int((weatherData.value?.current.feelslikeC.rounded()) ?? 0)) + "°")
        case Extra.Pressure.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Pressure.text,
                cellValue: String(Int(weatherData.value?.current.pressureMB.rounded() ?? 0)) + " hPa"
            )
        case Extra.Humidity.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Humidity.text,
                cellValue: String(Int(weatherData.value?.current.humidity.rounded() ?? 0)) + " %"
            )
        case Extra.Precipitation.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Precipitation.text,
                cellValue: String(weatherData.value?.current.precipMm ?? 0) + " mm"
            )
        case Extra.Visibility.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Visibility.text,
                cellValue: String(Int(weatherData.value?.current.visKM.rounded() ?? 0)) + " km"
            )
        case Extra.CloudsCoverage.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.CloudsCoverage.text,
                cellValue: String(Int(weatherData.value?.current.cloud.rounded() ?? 00)) + " %"
            )
        case Extra.Sunrise.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Sunrise.text,
                cellValue: { 
                    guard let time = weatherData.value?.forecast.forecastday.first?.astro.sunrise else { return "err"}
                    return time }()
            )
        case Extra.Sunset.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Sunset.text,
                cellValue: {
                    guard let time = weatherData.value?.forecast.forecastday.first?.astro.sunset else { return "err"}
                    return time }()
            )
        case Extra.Moonrise.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Moonrise.text,
                cellValue: {
                    guard let time = weatherData.value?.forecast.forecastday.first?.astro.moonrise else { return "err"}
                    return time }()
            )
        case Extra.Moonset.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.Moonset.text,
                cellValue: {
                    guard let time = weatherData.value?.forecast.forecastday.first?.astro.moonset else { return "err"}
                    return time }()
            )
        case Extra.WindSpeed.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.WindSpeed.text,
                cellValue: String(weatherData.value?.current.windKph ?? 0) + " Km/h"
            )
        case Extra.WindDirection.rawValue:
            ExtraSectionCellViewModel(
                cellName: Extra.WindDirection.text,
                cellValue: weatherData.value?.current.windDir ?? "err"
            )
        default:
            ExtraSectionCellViewModel(
                cellName: "err",
                cellValue: "err"
            )
        }
    }
    
    required init(weatherData: Weather) {
        self.weatherData.value = weatherData
    }
    
    enum Extra: Int, CaseIterable {
        case FeelsLike
        case Pressure
        case Humidity
        case Precipitation
        case Visibility
        case CloudsCoverage
        case Sunrise
        case Sunset
        case Moonrise
        case Moonset
        case WindSpeed
        case WindDirection
        
        var text: String {
            switch self {
                
            case .FeelsLike:
                "Feels like"
            case .Pressure:
                "Pressure"
            case .Humidity:
                "Humidity"
            case .Precipitation:
                "Precipitation"
            case .Visibility:
                "Visibility"
            case .CloudsCoverage:
                "Clouds coverage"
            case .Sunrise:
                "Sunrise"
            case .Sunset:
                "Sunset"
            case .Moonrise:
                "Moonrise"
            case .Moonset:
                "Moonset"
            case .WindSpeed:
                "Wind speed"
            case .WindDirection:
                "Wind direction"
            }
        }
    }
}

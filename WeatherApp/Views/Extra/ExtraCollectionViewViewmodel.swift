//
//  ExtraCollectionViewViewmodel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 12.10.2023.
//

import Foundation

protocol ExtraCollectionViewModelProtocol {
    init(weatherData: Weather)
    
    var weatherData: Weather { get }
    
    func getNumberOfItems() -> Int
    
    func getExtraSectionCellViewModel(at indexPath: IndexPath) -> ExtraCollectionViewCellViewModel
}

final class ExtraCollectionViewViewmodel: ExtraCollectionViewModelProtocol {
    
    let weatherData: Weather
    
    required init(weatherData: Weather) {
        self.weatherData = weatherData
    }
    
    func getNumberOfItems() -> Int {
        Extra.allCases.count
    }
    
    func getExtraSectionCellViewModel(at indexPath: IndexPath) -> ExtraCollectionViewCellViewModel {
        switch indexPath.row {
            
        case Extra.FeelsLike.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.FeelsLike.text,
                cellValue: String(Int((weatherData.current.feelslikeC.rounded()))) + "°")
        
        case Extra.Pressure.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Pressure.text,
                cellValue: String(Int(weatherData.current.pressureMB.rounded())) + " hPa"
            )
        
        case Extra.Humidity.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Humidity.text,
                cellValue: String(Int(weatherData.current.humidity.rounded())) + " %"
            )
        
        case Extra.Precipitation.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Precipitation.text,
                cellValue: String(weatherData.current.precipMm) + " mm"
            )
        
        case Extra.Visibility.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Visibility.text,
                cellValue: String(Int(weatherData.current.visKM.rounded())) + " km"
            )
        
        case Extra.CloudsCoverage.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.CloudsCoverage.text,
                cellValue: String(Int(weatherData.current.cloud.rounded())) + " %"
            )
        
        case Extra.Sunrise.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Sunrise.text,
                cellValue: {
                    guard 
                        let time = weatherData.forecast.forecastday.first?.astro.sunrise else { return "err"}
                    return time }()
            )
        
        case Extra.Sunset.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Sunset.text,
                cellValue: {
                    guard 
                        let time = weatherData.forecast.forecastday.first?.astro.sunset else { return "err"}
                    return time }()
            )
        
        case Extra.Moonrise.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Moonrise.text,
                cellValue: {
                    guard 
                        let time = weatherData.forecast.forecastday.first?.astro.moonrise else { return "err"}
                    return time }()
            )
        
        case Extra.Moonset.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.Moonset.text,
                cellValue: {
                    guard 
                        let time = weatherData.forecast.forecastday.first?.astro.moonset else { return "err"}
                    return time }()
            )
        
        case Extra.WindSpeed.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.WindSpeed.text,
                cellValue: String(weatherData.current.windKph) + " Km/h"
            )
        
        case Extra.WindDirection.rawValue:
            ExtraCollectionViewCellViewModel(
                cellName: Extra.WindDirection.text,
                cellValue: weatherData.current.windDir
            )
        
        default:
            ExtraCollectionViewCellViewModel(
                cellName: "err",
                cellValue: "err"
            )
        }
    }
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

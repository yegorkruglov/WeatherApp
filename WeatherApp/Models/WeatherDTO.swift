//
//  Weather.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let windDir: String
    let time: String?
    let precipMm: Double
    let humidity: Int
    let feelslikeC: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case precipMm = "precip_mm"
        case humidity
        case feelslikeC = "feelslike_c"
        case time
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day
    let hour: [Current]
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, mintempC: Double
    let totalprecipMm: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case totalprecipMm = "totalprecip_mm"
        case condition
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region: String
    let lat, lon: Double
    let localtime: String
}

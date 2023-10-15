//
//  Weather.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 28.09.2023.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
    
    static let zeroWeather = Weather.init(location: Location.init(name: "", region: "", country: "", lat: 0, lon: 0, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0), forecast: Forecast(forecastday: [Forecastday.init(date: "", dateEpoch: 0, day: Day.init(maxtempC: 0, maxtempF: 0, mintempC: 0, mintempF: 0, avgtempC: 0, avgtempF: 0, maxwindMph: 0, maxwindKph: 0, totalprecipMm: 0, totalprecipIn: 0, totalsnowCM: 0, avgvisKM: 0, avgvisMiles: 0, avghumidity: 0, dailyWillItRain: 0, dailyChanceOfRain: 0, dailyWillItSnow: 0, dailyChanceOfSnow: 0, condition: Condition(text: "", icon: "", code: 0), uv: 0), astro: Astro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", moonIllumination: "", isMoonUp: 0, isSunUp: 0), hour: [Hour.init(timeEpoch: 0, time: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, windchillC: 0, windchillF: 0, heatindexC: 0, heatindexF: 0, dewpointC: 0, dewpointF: 0, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0, visKM: 0, visMiles: 0, gustMph: 0, gustKph: 0, uv: 0)])]))
}

// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Double
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Double
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Double
    let windDir: String
    let pressureMB: Double
    let pressureIn: Double
    let precipMm, precipIn, humidity, cloud: Double
    let feelslikeC: Double
    let feelslikeF: Double
    let visKM, visMiles, uv: Double
    let gustMph, gustKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
    let code: Double
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let dateEpoch: Double
    let day: Day
    let astro: Astro
    let hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset: String
    let moonPhase, moonIllumination: String
    let isMoonUp, isSunUp: Double
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double
    let totalprecipMm, totalprecipIn: Double
    let totalsnowCM: Double
    let avgvisKM: Double
    let avgvisMiles, avghumidity, dailyWillItRain, dailyChanceOfRain: Double
    let dailyWillItSnow, dailyChanceOfSnow: Double
    let condition: Condition
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCM = "totalsnow_cm"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}

// MARK: - Hour
struct Hour: Codable {
    let timeEpoch: Double
    let time: String
    let tempC, tempF: Double
    let isDay: Double
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Double
    let windDir: String
    let pressureMB: Double
    let pressureIn, precipMm, precipIn: Double
    let humidity, cloud: Double
    let feelslikeC, feelslikeF, windchillC, windchillF: Double
    let heatindexC, heatindexF, dewpointC, dewpointF: Double
    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Double
    let visKM: Double
    let visMiles: Double
    let gustMph, gustKph: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Double
    let localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

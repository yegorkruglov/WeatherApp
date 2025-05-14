//
//  WeatherFormatter.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 14.05.2025.
//

import Foundation

enum WeatherFormatter {
    
    static func formatWeather(_ weather: Weather) -> WeatherFormatted {
        
        return WeatherFormatted(
            currentWeather: formatCurrentWeather(weather),
            hourlyWeather: formatHourlyWeather(weather),
            dailyWeather: formatDailyWeather(weather)
        )
    }
    
    private static func formatCurrentWeather(_ weather: Weather) -> CurrentWeather {
        
        let location = "\(weather.location.name), \(weather.location.region)"
        let currentTemperature = String(format: "%.1f", weather.current.tempC)
        let conditionDescription = weather.current.condition.text
        let currentConditionImageUrl = weather.current.condition.icon
        let feelsLikeTemperature = String(format: "%.1f", weather.current.feelslikeC)
        let precipitationMm = String(weather.current.precipMm)
        let windSpeed = String(weather.current.windKph)
        let windDirerction = weather.current.windDir
        let humidity = String(weather.current.humidity)
        
        return CurrentWeather(
            location: location,
            currentTemperature: currentTemperature,
            conditionDescription: conditionDescription,
            currentConditionImageUrl: currentConditionImageUrl,
            feelsLikeTemperature: feelsLikeTemperature,
            precipitationMm: precipitationMm,
            windSpeed: windSpeed,
            windDirection: windDirerction,
            humidity: humidity
        )
    }
    
    private static func formatHourlyWeather(_ weather: Weather) -> [HourlyWeather] {
        
        guard let forecastDay = weather.forecast.forecastday.first else { return [] }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let currenTimeString = weather.location.localtime
        
        guard let currentTime = dateFormatter.date(from: currenTimeString) else { return [] }
        
        let hours: [HourlyWeather] = forecastDay.hour
            .filter { weatherAtParticularHour in
                
                guard
                    let timeString = weatherAtParticularHour.time,
                    let time = dateFormatter.date(from: timeString)
                else { return false }
                
                return time > currentTime
            }
            .compactMap { weatherAtParticularHour in
                guard let formatedTimeString = formatDate(weatherAtParticularHour.time, fromFormat: "yyyy-MM-dd HH:mm", toFormat: "HH:mm") else { return nil }
                
                return HourlyWeather(
                    time: formatedTimeString,
                    conditionImageUrl: weatherAtParticularHour.condition.icon,
                    temperature: weatherAtParticularHour.tempC
                )
            }
        
        return hours
    }
    
    private static func formatDailyWeather(_ weather: Weather) -> [DailyWeather] {
        
        let days: [DailyWeather] = weather.forecast.forecastday
            .compactMap { forecastDay in
                guard
                    let formatedDateString = formatDate(
                        forecastDay.date,
                        fromFormat: "yyyy-MM-dd",
                        toFormat: "dd MMM"
                    )
                else { return nil }
                
                return DailyWeather(
                    date: formatedDateString,
                    conditionImageUrl: forecastDay.day.condition.icon,
                    conditionDescription: forecastDay.day.condition.text,
                    highTemperature: String(forecastDay.day.maxtempC),
                    lowTemperature: String(forecastDay.day.mintempC)
                )
            }
        
        return days
    }
    
    private static func formatDate(_ dateString: String?, fromFormat: String, toFormat format: String) -> String? {
        guard let dateString else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}

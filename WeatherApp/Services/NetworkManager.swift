//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 28.09.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let apiKey = "26ddef4fb93844228da170739232809"
    private let baseURL = "https://api.weatherapi.com/v1/"
    
    func requestWeatherFor(
        city name: String? = nil,
        latitude lat: Double? = nil,
        longitude long: Double? = nil,
        completion: @escaping (Result<Weather, NetworkError>) -> Void
    ) {
        var query: String?
        if let cityName = name {
            query = cityName
        } else if let lat = lat, let long = long {
            query = "\(lat),\(long)"
        }
        
        guard
            let query = query,
            let url = URL(
                string: "\(baseURL)forecast.json?key=\(apiKey)&q=\(query)&days=6&aqi=no&alerts=no"
            )
        else { return }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no data")
                completion(.failure(.noData))
                
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weatherResponse))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
    func search(query: String, completion: @escaping (Result<SearchResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)search.json?key=\(apiKey)&q=\(query)") else { return }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no data")
                completion(.failure(.noData))
                
                return
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(searchResponse))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
        
    }
    
    private init(){}
}

enum NetworkError: String, Error {
    case invalidURL
    case noData
    case decodingError
}

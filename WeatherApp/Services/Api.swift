//
//  Api.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import Foundation
import Combine

protocol ApiProtocol {
    func getWeatherInfoForLocation(lat: Double, long: Double) -> AnyPublisher<Weather, Error>
    func getImageFor(endpoint: String) -> AnyPublisher<Data, Error>
}

final class Api: ApiProtocol {
    private let networker: NetworkerProtocol
    
    private let weatherBaseUrl = "https://api.weatherapi.com/v1/"
    private let apiKey = "fa8b3df74d4042b9aa7135114252304"
    
    init(networker: NetworkerProtocol) {
        self.networker = networker
    }
    
    func getWeatherInfoForLocation(lat: Double, long: Double) -> AnyPublisher<Weather, Error> {
        guard let request = prepareRequest(.weatherInfo(lat, long)) else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return networker.processRequest(request)
    }
    
    func getImageFor(endpoint: String) -> AnyPublisher<Data, Error> {
        guard let request = prepareRequest(.image(endpoint)) else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return networker.processRequest(request)
    }
}

private extension Api {
    enum Request {
        case weatherInfo(Double, Double)
        case image(String)
        
        var httpMethod: String {
            switch self {
                default: "GET"
            }
        }
        
        var httpBody: Data? {
            switch self {
                default: nil
            }
        }
        
        var allHTTPHeaderFields: [String : String]? {
            switch self {
                default: nil
            }
        }
    }
    
    func prepareRequest(_ apiRequest: Api.Request) -> URLRequest? {
        let url: URL?
        
        switch apiRequest {
            
        case .weatherInfo(let lat, let long):
            url = URL(string: prepareUrlForLocation(lat: lat, long: long))
            
        case .image(let endpoint):
            url = URL(string: "https:" + endpoint)
        }
        
        guard let url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = apiRequest.httpMethod
        request.httpBody = apiRequest.httpBody
        request.allHTTPHeaderFields = apiRequest.allHTTPHeaderFields
        
        return request
    }
    
    func prepareUrlForLocation(lat: Double, long: Double) -> String {
        return weatherBaseUrl + "forecast.json?key=\(apiKey)" + "&q=\(lat),\(long)&days=7"
    }
}

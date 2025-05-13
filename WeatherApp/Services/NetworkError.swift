//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badResponse
    case decodingFailed
    
    var userDescription: String {
        switch self {
        case .badUrl:
            return "Bad URL"
        case .badResponse:
            return "Bad response"
        case .decodingFailed:
            return "Decoding failed"
        }
    }
}

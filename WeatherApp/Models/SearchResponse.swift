//
//  SearchResponse.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import Foundation

// MARK: - SearchResponseElement
struct SearchResponseElement: Codable {
    let id: Int
    let name, region, country: String
    let lat, lon: Double
    let url: String
}

typealias SearchResponse = [SearchResponseElement]

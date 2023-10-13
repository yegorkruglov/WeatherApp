//
//  SearchCellViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import Foundation

protocol SearchCellViewModelProtocol {
    var cityName: String { get }
    var areaName: String { get }
    
    init(locationData: SearchResponseElement)
}

final class SearchCellViewModel: SearchCellViewModelProtocol {
    var cityName: String { locationData.name }

    var areaName: String { locationData.region + ", " + locationData.country}
    
    private let locationData: SearchResponseElement
    
    init(locationData: SearchResponseElement) {
        self.locationData = locationData
    }
}

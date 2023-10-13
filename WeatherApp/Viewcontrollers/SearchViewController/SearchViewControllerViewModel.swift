//
//  SearchViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import Foundation

protocol SearchViewControllerViewModelProtocol {
    var searchResults: Bindable<SearchResponse> { get }
    var weatherData: Bindable<Weather?> { get }
    
    func searchFor(query: String)
    func getNumberOfRows() -> Int
    func searchBarCancelButtonClicked()
    func getWeatherForLocation(at indexPath: IndexPath)
    func getSearchCellViewModel(withLocation locationData: SearchResponseElement) -> SearchCellViewModelProtocol
    func getLocationData(at indexPath: IndexPath) -> SearchResponseElement
}

final class SearchViewControllerViewModel: SearchViewControllerViewModelProtocol {
    private let networkManager = NetworkManager.shared
    
    private(set) var searchResults = Bindable<SearchResponse> (value: [])
    private(set) var weatherData =  Bindable<Weather?> (value: nil)
    
    func searchFor(query: String) {
        networkManager.search(query: query) { [weak self] result in
            switch result {
            case .success(let searchResponse):
                self?.searchResults.value = searchResponse
                print(searchResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        searchResults.value.count
    }
    
    func searchBarCancelButtonClicked() {
        searchResults.value = []
    }
    
    func getWeatherForLocation(at indexPath: IndexPath) {
        networkManager.requestWeatherFor(
            latitude: searchResults.value[indexPath.row].lat,
            longitude: searchResults.value[indexPath.row].lon
        ) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                self?.weatherData.value = weatherResponse
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSearchCellViewModel(withLocation locationData: SearchResponseElement) -> SearchCellViewModelProtocol {
        SearchCellViewModel(locationData: locationData)
    }
    
    func getLocationData(at indexPath: IndexPath) -> SearchResponseElement {
        searchResults.value[indexPath.row]
    }
}

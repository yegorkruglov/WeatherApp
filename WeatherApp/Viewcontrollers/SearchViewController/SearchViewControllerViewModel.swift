//
//  SearchViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import Foundation

protocol SearchViewControllerViewModelProtocol {
    var searchResults: Bindable<SearchResponse> { get }
    
    func searchFor(query: String)
    func getNumberOfRows() -> Int
    func searchBarCancelButtonClicked()
}

final class SearchViewControllerViewModel: SearchViewControllerViewModelProtocol {
    private let networkManager = NetworkManager.shared
    
    private(set) var searchResults = Bindable<SearchResponse> (value: [])
    
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
}

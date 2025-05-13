//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import Foundation
import Combine

final class WeatherInfoViewModel {
    
    // MARK: - private properties
    
    private let api: ApiProtocol
    
    // MARK: - publishers
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: -  initilizers
    
    init(dependencies: Dependencies) {
        self.api = dependencies.resolve()
        
    }
    
    // MARK: - public methods
    
    func bind(_ input: Input) -> Output {
        
        return Output()
    }
}

// MARK: - entities

extension WeatherInfoViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
}

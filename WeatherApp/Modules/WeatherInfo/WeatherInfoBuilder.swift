//
//  WeatherInfoBuilder.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import Foundation

enum WeatherInfoBuilder {
    static func build(dependencies: Dependencies, onGoToSettingsButtonTap: @escaping () -> Void) -> WeatherInfoViewController {
        
        let vm = WeatherInfoViewModel(dependencies: dependencies, onGoToSettingsButtonTap: onGoToSettingsButtonTap)
        
        return WeatherInfoViewController(viewModel: vm)
    }
}


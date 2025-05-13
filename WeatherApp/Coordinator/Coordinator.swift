//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
}

final class Coordinator: CoordinatorProtocol {
    
    private let window: UIWindow?
    private let dependencies: Dependencies
    private let navController: UINavigationController
    
    init(window: UIWindow?, dependencies: Dependencies, navController: UINavigationController) {
        self.window = window
        self.dependencies = dependencies
        self.navController = navController
    }
    
    func start() {
        
        let weatherInfoViewController = WeatherInfoBuilder.build(
            dependencies: dependencies,
            onGoToSettingsButtonTap: goToAppSettings
        )
        
        navController.pushViewController(weatherInfoViewController, animated: false)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
    }
    
    func goToAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}


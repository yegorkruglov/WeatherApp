//
//  WetherInfoViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import UIKit

final class WetherInfoViewController: UIViewController {
    
    // MARK: - private properties
    
    private let viewModel: WeatherInfoViewModel
    
    // MARK: - initilizers
    
    init(viewModel: WeatherInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    
    override func loadView() {
        view = WeatherInfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


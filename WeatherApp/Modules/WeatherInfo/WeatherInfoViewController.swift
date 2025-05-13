//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import UIKit
import Combine

final class WeatherInfoViewController: UIViewController {
    
    // MARK: - private properties
    
    private let viewModel: WeatherInfoViewModel
    
    // MARK: - publishers
    
    private var cancellables: Set<AnyCancellable> = []
    private var reloadButtonPublisher = PassthroughSubject<Void, Never>()
    
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
        bind()
    }
}

// MARK: - private methods

private extension WeatherInfoViewController {
    
    func bind() {
        guard let view = view as? WeatherInfoView else { return }
        
        let viewInput = view.makeInput()
        
        let input = WeatherInfoViewModel.Input(
            errorReloadButtonPublisher: viewInput.errorReloadButtonPublisher,
            reloadButtonPublisher: reloadButtonPublisher.eraseToAnyPublisher()
        )
        
        let output = viewModel.bind(input)
        
        handle(output)
    }
    
    func handle(_ output: WeatherInfoViewModel.Output) {
        
    }
}

// MARK: - entities

extension WeatherInfoViewController {
    
    enum State {
        case error(Error)
        case loading
        case loaded(Weather)
        case locationAuthRequiredAlert
    }
}



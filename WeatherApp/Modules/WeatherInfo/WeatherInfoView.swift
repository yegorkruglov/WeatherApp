//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import UIKit
import Combine

final class WeatherInfoView: UIView {
    
    // MARK: - publishers
    
    private var cancellables: Set<AnyCancellable> = []
    private var errorReloadButtonPublisher = PassthroughSubject<Void, Never>()
    
    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public methods
    
    func makeInput() -> Input {
        Input(
            errorReloadButtonPublisher: errorReloadButtonPublisher.eraseToAnyPublisher()
        )
    }
    
    func handle(_ output: WeatherInfoViewModel.Output) {
        output.statePublisher
            .sink { [weak self] state in
                self?.display(state)
            }
            .store(in: &cancellables)
    }
}

// MARK: - private methods

private extension WeatherInfoView {
    
    func setup() {
        addViews()
        setupViews()
        makeConsraints()
    }
    
    func addViews() {
        
    }
    
    func setupViews() {
        backgroundColor = .systemGray6
    }
    
    func makeConsraints() {
        
    }
    
    func display(_ state: WeatherInfoViewController.State) {
        
    }
}

// MARK: - entities

extension WeatherInfoView {
    
    struct Input {
        let errorReloadButtonPublisher: AnyPublisher<Void, Never>
    }
}

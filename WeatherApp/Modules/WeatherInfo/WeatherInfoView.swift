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
    private lazy var errorView = ErrorView()
    private lazy var errorReloadButtonPublisher = errorView.reloadButtonPublisher
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
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
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.displayState(state)
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
        [errorView, activityIndicator].forEach { subview in
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupViews() {
        backgroundColor = .systemGray6
        errorView.isHidden = true
    }
    
    func makeConsraints() {
        NSLayoutConstraint.activate(
            [
                errorView.topAnchor.constraint(equalTo: topAnchor),
                errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
                errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
                errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            ]
        )
    }
    
    func displayState(_ state: WeatherInfoViewController.State) {
        switch state {
            
        case .error(let error):
            errorView.isHidden = false
            errorView.configureWith(error)
            activityIndicator.stopAnimating()
            
        case .loading:
            errorView.isHidden = true
            activityIndicator.startAnimating()
            
        case .loaded(let weatherFormatted):
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            
        case .locationAuthRequiredAlert:
            break
        }
    }
}

// MARK: - entities

extension WeatherInfoView {
    
    struct Input {
        let errorReloadButtonPublisher: AnyPublisher<Void, Never>
    }
}

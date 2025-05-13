//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import UIKit

final class WeatherInfoView: UIView {
    
    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}

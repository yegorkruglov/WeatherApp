//
//  DailySection.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

final class DailySection: UIView {
    
    private let dailyData = (1...7).map { _ in
        DailySectionCell(frame: .zero, date: "Some day", condition: "Cloudy", tempHigh: "H: 25", tempLow: "L: 15")
    }
    
    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: dailyData)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = Constants.insetM
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DailySection {
    func setupUI() {
        backgroundColor = .systemMint
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


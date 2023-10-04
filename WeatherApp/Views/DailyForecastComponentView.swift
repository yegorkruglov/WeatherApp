//
//  DailyForecastComponentView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

final class DailyForecastComponentView: UIView {
    private let date: String
    private let condition: String
    private let tempHigh: String
    private let tempLow: String
    
    private lazy var dateLabel = getLabel(text: date, font: Constants.fontS, alignment: .left)
    private lazy var conditionLabel = getLabel(text: condition, font: Constants.fontS, alignment: .center)
    private lazy var tempHighLabel = getLabel(text: tempHigh, font: Constants.fontS, alignment: .center)
    private lazy var tempLowLabel = getLabel(text: tempLow, font: Constants.fontS, alignment: .center)
    
    init(frame: CGRect, date: String, condition: String, tempHigh: String, tempLow: String) {
        self.date = date
        self.condition = condition
        self.tempHigh = tempHigh
        self.tempLow = tempLow
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DailyForecastComponentView {
    func setupUI() {
        backgroundColor = .brown
        layer.cornerRadius = Constants.cornerRadiusM
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel, conditionLabel, tempHighLabel, tempLowLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually        
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.insetM)
        }
    }
}

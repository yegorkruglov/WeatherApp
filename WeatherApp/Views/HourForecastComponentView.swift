//
//  HourForecastComponentView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

final class HourForecastComponentView: UIView {

    private let hour: String
    private let condition: String
    private let temp: String
    
    private lazy var hourLabel = getLabel(text: hour, font: Constants.fontS, alignment: .center)
    private lazy var conditionLabel = getLabel(text: condition, font: Constants.fontS, alignment: .center)
    private lazy var tempLabel = getLabel(text: temp, font: Constants.fontS, alignment: .center)
    
    init(frame: CGRect, hour: String, condition: String, temp: String) {
        self.hour = hour
        self.condition = condition
        self.temp = temp
        super.init(frame: frame)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension HourForecastComponentView {
    func setupUI() {
        backgroundColor = .cyan
        layer.cornerRadius = Constants.cornerRadiusM
        
        let stackView = UIStackView(arrangedSubviews: [hourLabel, conditionLabel, tempLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

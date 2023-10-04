//
//  CurrentWeatherSummaryView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class CurrentWeatherSummaryView: UIView {
    
    private lazy var locationNameLbael = getLabel(text: "Location", font: Constants.fontL)
    private lazy var conditionLabel = getLabel(text: "Condition", font: Constants.fontM)
    private lazy var currentTempLabel = getLabel(text: "20", font: Constants.fontL, alignment: .center)
    private lazy var highTempLabel = getLabel(text: "H: 25", font: Constants.fontS, alignment: .center)
    private lazy var lowTempLabel = getLabel(text: "L: 15", font: Constants.fontS, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CurrentWeatherSummaryView {
    func setupUI() {
        backgroundColor = .purple
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(locationNameLbael)
        locationNameLbael.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.insetM)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(1.5)
        }
        
        addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalTo(locationNameLbael)
            make.width.equalTo(locationNameLbael)
            make.top.equalTo(locationNameLbael.snp.bottom)
        }
        
        addSubview(currentTempLabel)
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(locationNameLbael)
            make.leading.equalTo(locationNameLbael.snp.trailing)
            make.trailing.equalToSuperview().inset(Constants.insetM)
        }
        
        addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom)
            make.bottom.equalTo(conditionLabel.snp.bottom)
            make.leading.equalTo(conditionLabel.snp.trailing)
            make.width.equalTo(currentTempLabel).dividedBy(2)
        }
        
        addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { make in
            make.size.equalTo(highTempLabel)
            make.top.equalTo(highTempLabel)
            make.leading.equalTo(highTempLabel.snp.trailing)
        }
    }
}

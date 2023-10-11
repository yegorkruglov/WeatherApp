//
//  CurrentWetherComponentView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class CurrentWetherExtraInfoComponentView: UIView {
    private let componentName: String
    private let value: String
    
    private lazy var componentNameLabel = getLabel(text: componentName, font: Constants.fontM, alignment: .center)
    private lazy var valueLabel = getLabel(text: value, font: Constants.fontL, alignment: .center)

    init(frame: CGRect, componentName: String, value: String) {
        self.value = value
        self.componentName = componentName
        super.init(frame: frame)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CurrentWetherExtraInfoComponentView {
    func setupUI() {
        backgroundColor = .orange
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(componentNameLabel)
        componentNameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(Constants.insetM)
            make.height.equalToSuperview().dividedBy(4)
        }
        
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(Constants.insetM)
            make.top.equalTo(componentNameLabel.snp.bottom)
        }
    }
}

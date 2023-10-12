//
//  ExtraSection.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class ExtraSection: UIView {
    
    private var feelsLikeComponentView = ExtraSectionCell(frame: .zero, componentName: "Feels like", value: "20")
    private var pressureComponentView = ExtraSectionCell(frame: .zero, componentName: "Pressure", value: "1013")
    private var humidityComponentView = ExtraSectionCell(frame: .zero, componentName: "Humidity", value: "78%")
    private var precipitationComponantView = ExtraSectionCell(frame: .zero, componentName: "Precipitation", value: "0 mm")
    private var visibilityComponentView = ExtraSectionCell(frame: .zero, componentName: "Visibility", value: "14 km")
    private var cloudsComponentView = ExtraSectionCell(frame: .zero, componentName: "Clouds", value: "Sky clear")
    private var sunComponentView = ExtraSectionCell(frame: .zero, componentName: "Sun", value: "Up at: \n06:55 AM\nDown at: \n06:33 PM")
    private var moonComponentView = ExtraSectionCell(frame: .zero, componentName: "Moon", value: "Up at: \n09:49 PM\nDown at: \n01:02 PM")
    private var windComponentView = ExtraSectionCell(frame: .zero, componentName: "Wind", value: "NW, 2 m/s\nGust up to 5 m/s")
    
    private lazy var components = [
        feelsLikeComponentView,
        pressureComponentView,
        humidityComponentView,
        precipitationComponantView,
        visibilityComponentView,
        cloudsComponentView,
        sunComponentView,
        moonComponentView,
        windComponentView
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ExtraSection {
    func setupUI() {
        backgroundColor = .systemPink
        layer.cornerRadius = Constants.cornerRadiusM
        
        stackUpComponents(components: &components)
    }
    
    func stackUpComponents(components: inout [some UIView]) {
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = Constants.insetM
        
        let numberOfTwoItemsStacks = components.count / 2
        
        for _ in 1...numberOfTwoItemsStacks {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = Constants.insetM
            
            for _ in 1...2 {
                horizontalStack.addArrangedSubview(components.removeFirst())
            }
            
            verticalStack.addArrangedSubview(horizontalStack)
        }
        
        verticalStack.addArrangedSubview(components.removeFirst())
        
        addSubview(verticalStack)
        verticalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

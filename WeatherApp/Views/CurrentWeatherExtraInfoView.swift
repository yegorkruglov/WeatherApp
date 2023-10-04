//
//  CurrentWeatherExtraInfoView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class CurrentWeatherExtraInfoView: UIView {
    
    private var feelsLikeComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Feels like", value: "20")
    private var pressureComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Pressure", value: "1013")
    private var humidityComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Humidity", value: "78%")
    private var precipitationComponantView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Precipitation", value: "0 mm")
    private var visibilityComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Visibility", value: "14 km")
    private var cloudsComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Clouds", value: "Sky clear")
    private var sunComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Sun", value: "Up at: \n06:55 AM\nDown at: \n06:33 PM")
    private var moonComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Moon", value: "Up at: \n09:49 PM\nDown at: \n01:02 PM")
    private var windComponentView = CurrentWetherExtraInfoComponentView(frame: .zero, componentName: "Wind", value: "NW, 2 m/s\nGust up to 5 m/s")
    
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

private extension CurrentWeatherExtraInfoView {
    func setupUI() {
        backgroundColor = .systemPink
        layer.cornerRadius = Constants.cornerRadiusM
        
        stackUpComponents(components: &components)
    }
}

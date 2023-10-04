//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class WeatherView: UIView {
    
    private var summary = CurrentWeatherSummaryView(frame: .zero)
    private var extra = CurrentWeatherExtraInfoView(frame: .zero)
    private var hourly = HourlyForecastView(frame: .zero)
    private var daily = DailyForecastView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeatherView {
    func setupUI() {
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(summary)
        summary.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().dividedBy(6)
        }
        
        addSubview(extra)
        extra.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(summary)
            make.top.equalTo(summary.snp.bottom).offset(Constants.insetM)
            make.bottom.equalToSuperview()
        }
        
        addSubview(hourly)
        hourly.snp.makeConstraints { make in
            make.size.equalTo(summary)
            make.horizontalEdges.equalTo(summary)
            make.top.equalTo(extra.snp.bottom).offset(Constants.insetM)
        }
        
        addSubview(daily)
        daily.snp.makeConstraints { make in
            make.height.equalTo(extra)
            make.width.equalTo(extra)
            make.top.equalTo(hourly.snp.bottom).offset(Constants.insetM)
        }
    }
}

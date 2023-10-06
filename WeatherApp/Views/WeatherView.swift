//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class WeatherView: UIView {
    
    private var summary = CurrentWeatherSummaryView()
    private var extra = CurrentWeatherExtraInfoView()
    private var hourly = HourlyForecastView()
    private var daily = DailyForecastView()
    
    private lazy var scrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.layer.cornerRadius = Constants.cornerRadiusM
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constants.insetM * 3, right: 0)
    
        return scroll
    }()
    
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
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = Constants.cornerRadiusM
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(2)
        }
        
        contentView.addSubview(summary)
        summary.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().dividedBy(12)
        }
        
        contentView.addSubview(hourly)
        hourly.snp.makeConstraints { make in
            make.top.equalTo(summary.snp.bottom).offset(Constants.insetM)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(summary)
        }

        contentView.addSubview(extra)
        extra.snp.makeConstraints { make in
            make.top.equalTo(hourly.snp.bottom).offset(Constants.insetM)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(summary).multipliedBy(5)
        }
        
        contentView.addSubview(daily)
        daily.snp.makeConstraints { make in
            make.top.equalTo(extra.snp.bottom).offset(Constants.insetM)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(summary).multipliedBy(5)
        }
    }
}

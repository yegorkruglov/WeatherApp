//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

final class HourlyForecastView: UIView {
    
    private let hourData = (1...12).map { _ in
        HourForecastComponentView(frame: .zero, hour: "hour", condition: "cond", temp: "temp")
    }
    
    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: hourData)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = Constants.insetM
        
        return stack
    }()
    
    lazy var scrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.layer.cornerRadius = Constants.cornerRadiusM
        
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

private extension HourlyForecastView {
    func setupUI() {
        backgroundColor = .systemYellow
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(scrollView)
            make.width.equalTo(scrollView).multipliedBy(3.5)
            make.horizontalEdges.equalTo(scrollView)
        }
    }
}

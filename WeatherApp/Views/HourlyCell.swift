//
//  HourlyCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

class HourlyCell: UITableViewCell {
    static var identifier: String { String(describing: self) }
    
    var viewModel: HourlyCellViewModelProtocol! {
        didSet {
            
        }
    }
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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


//
//  HourlySectionCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

final class HourlySectionCell: UICollectionViewCell {
    static var identifier: String { String(describing: self) }
    
//    private let hour: String
//    private let condition: String
//    private let temp: String
    
    private lazy var hourLabel = UILabel()
    private lazy var conditionLabel = UILabel()
    private lazy var tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HourlySectionCell {
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

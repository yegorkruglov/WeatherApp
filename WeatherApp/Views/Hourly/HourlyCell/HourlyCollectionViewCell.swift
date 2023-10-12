//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit
import Kingfisher

final class HourlyCollectionViewCell: UICollectionViewCell {
    static var identifier: String { String(describing: self) }
    
    var viewModel: HourlyCollectionViewCellViewModelProtocol! {
        didSet {
            hourLabel.text = viewModel.hourText
            tempLabel.text = viewModel.tempText
            conditionImageView.kf.setImage(with: viewModel.conditionImageURL)
        }
    }
    
    private lazy var hourLabel = getLabel(font: Constants.fontM, alignment: .center)
    private lazy var tempLabel = getLabel(font: Constants.fontM, alignment: .center)
    private lazy var conditionImageView = getImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HourlyCollectionViewCell {
    func setupUI() {
        backgroundColor = .appGray
        layer.cornerRadius = Constants.cornerRadiusM
        
        let stackView = UIStackView(arrangedSubviews: [hourLabel, conditionImageView, tempLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

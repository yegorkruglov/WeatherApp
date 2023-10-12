//
//  HourlySectionCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit
import Kingfisher

final class HourlySectionCell: UICollectionViewCell {
    static var identifier: String { String(describing: self) }
    
    var viewModel: HourlySectionCellViewModelProtocol! {
        didSet {
            hourLabel.text = viewModel.hourText
            tempLabel.text = viewModel.tempText
            conditionImageView.kf.setImage(with: viewModel.conditionImageURL)
        }
    }
    
    private lazy var hourLabel = getLabel(font: Constants.fontM, alignment: .center)
    private lazy var conditionImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }()
    private lazy var tempLabel = getLabel(font: Constants.fontM, alignment: .center)
    
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
        
        let stackView = UIStackView(arrangedSubviews: [hourLabel, conditionImageView, tempLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

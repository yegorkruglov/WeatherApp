//
//  DailySectionCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit
import Kingfisher

final class DailySectionCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: DailySectionCellViewModelProtocol! {
        didSet {
            dateLabel.text = viewModel.dateText
            conditionImageView.kf.setImage(with: viewModel.conditionImageURL)
            conditionLabel.text = viewModel.conditionText
            tempHighLabel.text = viewModel.tempHighText
            tempLowLabel.text = viewModel.tempLowText
        }
    }
    
    private lazy var dateLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var conditionImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }()
    private lazy var conditionLabel = getLabel(font: Constants.fontS, alignment: .left)
    private lazy var tempHighLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var tempLowLabel = getLabel(font: Constants.fontS, alignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DailySectionCell {
    func setupUI() {
//        backgroundColor = .brown
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(dateLabel)
        addSubview(conditionImageView)
        addSubview(conditionLabel)
        addSubview(tempHighLabel)
        addSubview(tempLowLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(Constants.insetS)
            make.width.equalTo(dateLabel.snp.height)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.width.top.bottom.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing)
        }
        
        tempLowLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(Constants.insetS)
            make.width.equalTo(dateLabel)
        }
        
        tempHighLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(tempLowLabel)
            make.trailing.equalTo(tempLowLabel.snp.leading)
            make.width.equalTo(tempLowLabel)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(dateLabel)
            make.leading.equalTo(conditionImageView.snp.trailing).offset(Constants.insetS)
            make.trailing.equalTo(tempHighLabel.snp.leading)
        }
    }
}

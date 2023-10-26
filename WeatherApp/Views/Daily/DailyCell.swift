//
//  DailyCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit
import Kingfisher

final class DailyCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: DailyCellViewModelProtocol! {
        didSet {
            dateLabel.text = viewModel.dateText
            conditionImageView.kf.setImage(with: viewModel.conditionImageURL)
            conditionLabel.text = viewModel.conditionText
            tempHighLabel.text = viewModel.tempHighText
            tempLowLabel.text = viewModel.tempLowText
        }
    }
    
    private lazy var dateLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var conditionLabel = getLabel(font: Constants.fontS, alignment: .left)
    private lazy var tempHighLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var tempLowLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var conditionImageView = getImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DailyCell {
    func setupUI() {
        layer.cornerRadius = Constants.cornerRadiusM
        
        lazy var backgroundView = getBackgroundView()
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(Constants.insetS)
        }
        
        backgroundView.addSubview(dateLabel)
        backgroundView.addSubview(conditionImageView)
        backgroundView.addSubview(conditionLabel)
        backgroundView.addSubview(tempHighLabel)
        backgroundView.addSubview(tempLowLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(Constants.insetM)
            make.width.equalToSuperview().dividedBy(7)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(dateLabel)
            make.width.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing)
        }
        
        tempLowLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(Constants.insetM)
            make.width.equalTo(dateLabel)
        }
        
        tempHighLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(tempLowLabel)
            make.trailing.equalTo(tempLowLabel.snp.leading)
            make.width.equalTo(dateLabel)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(dateLabel)
            make.leading.equalTo(conditionImageView.snp.trailing).offset(Constants.insetM)
            make.trailing.equalTo(tempHighLabel.snp.leading)
        }
    }
}

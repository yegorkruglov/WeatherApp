//
//  SummaryCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import UIKit

final class SummaryCell: UITableViewCell {
    
    // MARK: Public propeties
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: SummaryCellViewModelProtocol! {
        didSet {
            locationNameLbael.text = viewModel.locationName
            conditionLabel.text = viewModel.conditionText
            currentTempLabel.text = viewModel.currentTempText
            highTempLabel.text = viewModel.highestTempText
            lowTempLabel.text = viewModel.lowestTempText
            conditionImageView.kf.setImage(with: viewModel.conditionImageURL)
        }
    }
    
    // MARK: - Private Properties
    private lazy var locationNameLbael = getLabel(font: Constants.fontL)
    private lazy var conditionLabel = getLabel(font: Constants.fontM)
    private lazy var currentTempLabel = getLabel(font: Constants.fontL, alignment: .center)
    private lazy var highTempLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var lowTempLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var conditionImageView = getImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Cell setup

extension SummaryCell {
    private func setupUI() {
        backgroundColor = .appGray
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(locationNameLbael)
        locationNameLbael.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Constants.insetM)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        addSubview(currentTempLabel)
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.insetM)
            make.leading.equalTo(locationNameLbael.snp.trailing)
            make.trailing.equalToSuperview().inset(Constants.insetM)
            make.height.equalTo(locationNameLbael)
        }
        
        addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(currentTempLabel)
            make.top.equalTo(currentTempLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(Constants.insetM)
            make.width.equalTo(currentTempLabel).dividedBy(2)
        }
        
        addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(lowTempLabel)
            make.trailing.equalTo(lowTempLabel.snp.leading)
        }
        
        addSubview(conditionImageView)
        conditionImageView.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(lowTempLabel)
            make.leading.equalTo(locationNameLbael)
        }
        
        addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(lowTempLabel)
            make.leading.equalTo(conditionImageView.snp.trailing).offset(Constants.insetM)
            make.trailing.equalTo(highTempLabel.snp.leading)
        }
    }
}

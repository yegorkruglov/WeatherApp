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
        layer.cornerRadius = Constants.cornerRadiusM
        
        let backGroundView = UIView()
        backGroundView.backgroundColor = .appGray
        backGroundView.layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(backGroundView)
        backGroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(Constants.insetS)
        }
        
        backGroundView.addSubview(locationNameLbael)
        locationNameLbael.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.insetL)
            make.leading.equalToSuperview().inset(Constants.insetXL)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        backGroundView.addSubview(currentTempLabel)
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.insetL)
            make.leading.equalTo(locationNameLbael.snp.trailing)
            make.trailing.equalToSuperview().inset(Constants.insetM)
            make.height.equalTo(locationNameLbael)
        }
        
        backGroundView.addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(currentTempLabel)
            make.top.equalTo(currentTempLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(Constants.insetM)
            make.width.equalTo(currentTempLabel).dividedBy(2)
        }
        
        backGroundView.addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(lowTempLabel)
            make.trailing.equalTo(lowTempLabel.snp.leading)
        }
        
        backGroundView.addSubview(conditionImageView)
        conditionImageView.snp.makeConstraints { make in
            make.top.bottom.width.equalTo(lowTempLabel)
            make.leading.equalToSuperview().inset(Constants.insetM)
        }
        
        backGroundView.addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(lowTempLabel)
            make.leading.equalTo(conditionImageView.snp.trailing).offset(Constants.insetM)
            make.trailing.equalTo(highTempLabel.snp.leading)
        }
    }
}

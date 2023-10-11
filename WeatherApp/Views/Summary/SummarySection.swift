//
//  SummarySection.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 10.10.2023.
//

import UIKit

class SummarySection: UITableViewCell {
    static var identifier: String { String(describing: self) }
    
    var viewModel: SummarySectionViewModelProtocol! {
        didSet {
            locationNameLbael.text = viewModel.locationName
            conditionLabel.text = viewModel.conditionText
            currentTempLabel.text = viewModel.currentTempText
            highTempLabel.text = viewModel.highestTempText
            lowTempLabel.text = viewModel.lowestTempText
            conditionImageView.kf.setImage(with: viewModel.conditionImageURL)
        }
    }
    
    private lazy var locationNameLbael = getLabel(text: "Location", font: Constants.fontL)
    private lazy var conditionLabel = getLabel(text: "Condition", font: Constants.fontM)
    private lazy var currentTempLabel = getLabel(text: "Temp", font: Constants.fontL, alignment: .center)
    private lazy var highTempLabel = getLabel(text: "H:", font: Constants.fontS, alignment: .center)
    private lazy var lowTempLabel = getLabel(text: "L:", font: Constants.fontS, alignment: .center)
    private lazy var conditionImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .purple
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(locationNameLbael)
        locationNameLbael.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.insetM)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(1.5)
        }
        
        addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalTo(locationNameLbael)
            make.width.equalTo(locationNameLbael)
            make.top.equalTo(locationNameLbael.snp.bottom)
        }
        
        addSubview(currentTempLabel)
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(locationNameLbael)
            make.leading.equalTo(locationNameLbael.snp.trailing)
            make.trailing.equalToSuperview().inset(Constants.insetM)
        }
        
        addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom)
            make.bottom.equalTo(conditionLabel.snp.bottom)
            make.leading.equalTo(conditionLabel.snp.trailing)
            make.width.equalTo(currentTempLabel).dividedBy(2)
        }
        
        addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { make in
            make.size.equalTo(highTempLabel)
            make.top.equalTo(highTempLabel)
            make.leading.equalTo(highTempLabel.snp.trailing)
        }
        
        addSubview(conditionImageView)
        conditionImageView.snp.makeConstraints { make in
            make.bottom.width.height.equalTo(highTempLabel)
            make.trailing.equalTo(highTempLabel.snp.leading)
        }
    }

}

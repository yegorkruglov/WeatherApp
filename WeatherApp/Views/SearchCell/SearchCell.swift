//
//  SearchCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: SearchCellViewModelProtocol! {
        didSet {
            cityLabel.text = viewModel.cityName
            areaLabel.text = viewModel.areaName
        }
    }
    
    private lazy var cityLabel = getLabel(font: Constants.fontM)
    private lazy var areaLabel = getLabel(font: Constants.fontS, textColor: .appBlue)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchCell {
    func setupUI() {
        layer.cornerRadius = Constants.cornerRadiusM
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .appGray
        backgroundView.layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(Constants.insetS)
        }
        
        backgroundView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(Constants.insetM)
            make.bottom.equalToSuperview().dividedBy(2)
        }
        
        backgroundView.addSubview(areaLabel)
        areaLabel.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview().inset(Constants.insetM)
            make.top.equalTo(cityLabel.snp.bottom).offset(Constants.insetM)
        }
    }
}

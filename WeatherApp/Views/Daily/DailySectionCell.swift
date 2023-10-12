//
//  DailySectionCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

final class DailySectionCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: DailySectionCellViewModelProtocol! {
        didSet {
            dateLabel.text = viewModel.dateText
            conditionLabel.text = viewModel.conditionText
            tempHighLabel.text = viewModel.tempHighText
            tempLowLabel.text = viewModel.tempLowText
        }
    }
    
    private lazy var dateLabel = getLabel(font: Constants.fontS, alignment: .center)
    private lazy var conditionLabel = getLabel(font: Constants.fontS, alignment: .center)
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
        backgroundColor = .brown
        layer.cornerRadius = Constants.cornerRadiusM
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel, conditionLabel, tempHighLabel, tempLowLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually        
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.insetM)
        }
    }
}

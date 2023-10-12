//
//  ExtraSectionCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class ExtraSectionCell: UICollectionViewCell {
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: ExtraSectionCellViewModelProtocol! {
        didSet {
            cellNameLabel.text = viewModel.cellName
            valueLabel.text = viewModel.cellValue
        }
    }
    
    private lazy var cellNameLabel = getLabel(font: Constants.fontM, alignment: .center)
    private lazy var valueLabel = getLabel(font: Constants.fontL, alignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ExtraSectionCell {
    func setupUI() {
        backgroundColor = .orange
        layer.cornerRadius = Constants.cornerRadiusM
        
        addSubview(cellNameLabel)
        cellNameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(Constants.insetM)
            make.height.equalToSuperview().dividedBy(5)
        }
        
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(Constants.insetM)
            make.top.equalTo(cellNameLabel.snp.bottom)
        }
    }
}

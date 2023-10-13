//
//  SearchCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import UIKit

class SearchCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: DailyCellViewModelProtocol! {
        didSet {

            
        }
    }

    private lazy var locationLabel = getLabel(font: Constants.fontM)
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        locationLabel.text = "some location"
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
        
        backgroundView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.insetM)
        }
        
    }
}

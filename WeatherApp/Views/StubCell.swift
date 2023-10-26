//
//  StubCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 26.10.2023.
//

import UIKit

final class StubCell: UITableViewCell {
    static var identifier: String { String(describing: self) }

    private let activityIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension StubCell {
    func setupUI() {
        layer.cornerRadius = Constants.cornerRadiusM
        
        lazy var backgroundView = getBackgroundView()
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(Constants.insetS)
        }
        
        backgroundView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
}

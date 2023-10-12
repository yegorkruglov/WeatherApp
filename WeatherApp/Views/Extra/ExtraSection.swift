//
//  ExtraSection.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class ExtraSection: UIView {
    
    private var feelsLikeCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Feels like",
        value: "20"
    )
    private var pressureCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Pressure",
        value: "1013"
    )
    private var humidityCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Humidity",
        value: "78%"
    )
    private var precipitationCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Precipitation",
        value: "0 mm"
    )
    private var visibilityCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Visibility",
        value: "14 km"
    )
    private var cloudsCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Clouds",
        value: "Sky clear"
    )
    private var sunCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Sun",
        value: "Up at: \n06:55 AM\nDown at: \n06:33 PM"
    )
    private var moonCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Moon",
        value: "Up at: \n09:49 PM\nDown at: \n01:02 PM"
    )
    private var windCell = ExtraSectionCell(
        frame: .zero,
        componentName: "Wind",
        value: "NW, 2 m/s\nGust up to 5 m/s"
    )
    
    private lazy var cells = [
        feelsLikeCell,
        pressureCell,
        humidityCell,
        precipitationCell,
        visibilityCell,
        cloudsCell,
        sunCell,
        moonCell,
        windCell
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ExtraSection {
    func setupUI() {
        backgroundColor = .systemPink
        layer.cornerRadius = Constants.cornerRadiusM
        
        stackUpCells(cells: &cells)
    }
    
    func stackUpCells(cells: inout [some UIView]) {
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = Constants.insetM
        
        let numberOfTwoItemsStacks = cells.count / 2
        
        for _ in 1...numberOfTwoItemsStacks {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = Constants.insetM
            
            for _ in 1...2 {
                horizontalStack.addArrangedSubview(cells.removeFirst())
            }
            
            verticalStack.addArrangedSubview(horizontalStack)
        }
        
        verticalStack.addArrangedSubview(cells.removeFirst())
        
        addSubview(verticalStack)
        verticalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

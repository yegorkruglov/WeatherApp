//
//  Extension +UIView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

extension UIView {  
    func getLabel(text: String, font: UIFont, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.textAlignment = alignment
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
    
    func stackUpComponents(components: inout [some UIView]) {
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = Constants.insetM
        
        let numberOfTwoItemsStacks = components.count / 2
        
        for _ in 1...numberOfTwoItemsStacks {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = Constants.insetM
            
            for _ in 1...2 {
                horizontalStack.addArrangedSubview(components.removeFirst())
            }
            
            verticalStack.addArrangedSubview(horizontalStack)
        }
        
        verticalStack.addArrangedSubview(components.removeFirst())
        
        addSubview(verticalStack)
        verticalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

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
    
}

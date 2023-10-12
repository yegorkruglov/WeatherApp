//
//  Extension +UIView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

extension UIView {  
    var viewHeight: CGFloat { frame.height }
    var viewWidth: CGFloat { frame.width }
    
    func getLabel(font: UIFont, alignment: NSTextAlignment = .left, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.textAlignment = alignment
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
}

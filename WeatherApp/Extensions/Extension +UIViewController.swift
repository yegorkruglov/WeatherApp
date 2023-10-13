//
//  Extension +UIViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 09.10.2023.
//

import UIKit

extension UIViewController {
    var screenHeight: CGFloat { view.frame.height }
    var screenWidth: CGFloat { view.frame.width }
    
    var heightXS: CGFloat { screenHeight / 8 }
    var heightS: CGFloat { screenHeight / 6 }
    var heightM: CGFloat { screenHeight / 3 }
    var heightL: CGFloat { screenHeight / 1.25 }
}

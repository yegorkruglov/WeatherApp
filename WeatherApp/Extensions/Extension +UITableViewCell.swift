//
//  Extension +UITableViewCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 26.10.2023.
//

import UIKit

extension UITableViewCell {
    func getBackgroundView() -> UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .appGray
        backgroundView.layer.cornerRadius = Constants.cornerRadiusM
        
        return backgroundView
    }
    
    
}

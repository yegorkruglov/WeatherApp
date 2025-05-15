//
//  UICollectionViewCell + Identifier.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 15.05.2025.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String { String(describing: Self.self) }
}

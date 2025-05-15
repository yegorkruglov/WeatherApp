//
//  ItemConfigurable.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 15.05.2025.
//

import Foundation

protocol ItemConfigurable: AnyObject {
    associatedtype ItemType
    func configure(with item: ItemType)
}

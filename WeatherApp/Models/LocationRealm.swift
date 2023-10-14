//
//  LocationRealm.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 14.10.2023.
//

import Foundation
import RealmSwift

final class LocationRealm: Object {
    @Persisted var latitude: Double = 0
    @Persisted var longitude: Double = 0
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}

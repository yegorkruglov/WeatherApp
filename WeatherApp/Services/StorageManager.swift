//
//  StorageManager.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 14.10.2023.
//

import Foundation
import RealmSwift

final class StorageManager {
    static let shared = StorageManager()
    
    let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func save(_ location: Location, completion: (LocationRealm) -> Void) {
        write {
            let location = LocationRealm(latitude: location.lat, longitude: location.lon)
            
            completion(location)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}

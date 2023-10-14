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
            let newLocation = LocationRealm(latitude: location.lat, longitude: location.lon)
            
            let savedLocations = realm.objects(LocationRealm.self)

            guard !savedLocations.contains(where: { savedLocation in
                savedLocation.latitude == newLocation.latitude
                && savedLocation.longitude == newLocation.longitude
            }) else { return }
            
            realm.add(newLocation)
            
            completion(newLocation)
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

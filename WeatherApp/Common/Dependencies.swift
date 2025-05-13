//
//  Dependencies.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import Foundation
import CoreLocation

final class Dependencies {
    private lazy var session = URLSession.shared
    private lazy var decoder = JSONDecoder()
    private lazy var networker = Networker(session: session, decoder: decoder)
    private lazy var api = Api(networker: networker)
    
    func resolve() -> URLSession {
        return session
    }
    
    func resolve() -> JSONDecoder {
        return decoder
    }
    
    func resolve() -> NetworkerProtocol {
        return networker
    }
    
    func resolve() ->  ApiProtocol {
        return api
    }
    
    func resolve() -> CLLocationManager {
        return CLLocationManager()
    }
}

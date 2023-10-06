//
//  CurentLocationViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 28.09.2023.
//

import UIKit
import CoreLocation
import SnapKit

final class CurentLocationViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let networkManager = NetworkManager.shared
    private let locationManager = CLLocationManager()
    private var currentCoordinates: CLLocationCoordinate2D? {
        didSet {
            requestWeatherForCurrentlocation()
        }
    }
    private var weatherData: Weather? {
        didSet {
            updateUIWithWeatherData()
        }
    }
    
    private var weatherView = WeatherView()
    private lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        locationManager.delegate = self
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestCurrentLocation()
    }
}

private extension CurentLocationViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(weatherView)
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(Constants.insetS)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(Constants.insetS)
            make.horizontalEdges.equalToSuperview().inset(Constants.insetL)
        }
        
        weatherView.alpha = 1
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    func requestCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func requestWeatherForCurrentlocation() {
        guard (currentCoordinates != nil) else {
            print("No location -> no weather")
            return
        }
        
        networkManager.requestWeatherFor(
            latitude: currentCoordinates?.latitude,
            longitude: currentCoordinates?.longitude
        ) { result in
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func updateUIWithWeatherData() {
        activityIndicator.stopAnimating()
        
    }
}

// MARK: - CLLocationManagerDelegate

extension CurentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentCoordinates = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

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
    
    private lazy var scrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.layer.cornerRadius = Constants.cornerRadiusM
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constants.insetM, right: 0)
        
        return scroll
    }()
    private var weatherView = WeatherView(frame: .zero)
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
//        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        requestCurrentLocation()
    }
}

private extension CurentLocationViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(weatherView)
        scrollView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(Constants.insetS)
            make.horizontalEdges.equalToSuperview().inset(Constants.insetL)
        }
        
        weatherView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview().dividedBy(2)
        }
    
        scrollView.alpha = 1
//
//        view.addSubview(activityIndicator)
//        activityIndicator.center = view.center
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
        
        //        networkManager.requestWeatherFor(
        //            latitude: currentCoordinates?.latitude,
        //            longitude: currentCoordinates?.longitude
        //        ) { result in
        //            switch result {
        //            case .success(let weatherResponse):
        //                self.weatherData = weatherData
        //            case .failure(let error):
        //                print(error.rawValue)
        //            }
        //        }
        
        networkManager.requestWeatherFor(city: "New York") { result in
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

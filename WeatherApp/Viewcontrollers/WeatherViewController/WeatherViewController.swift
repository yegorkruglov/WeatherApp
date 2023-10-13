//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 28.09.2023.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableView = UITableView()
    
    private let viewModel: WeatherViewControllerViewModelProtocol = WeatherViewControllerViewModel()
    
    private lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureTableView()
        configureViewModelObserver()
    }
}

// MARK: - WeatherViewController setup

private extension WeatherViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        tableView.layer.cornerRadius = Constants.cornerRadiusM
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.insetL)
            make.verticalEdges.equalTo(self.view.safeAreaLayoutGuide.snp.verticalEdges)
        }
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        tableView.register(HourlyCollectionView.self, forCellReuseIdentifier: HourlyCollectionView.identifier)
        tableView.register(ExtraCollectionView.self, forCellReuseIdentifier: ExtraCollectionView.identifier)
        tableView.register(DailyCell.self, forCellReuseIdentifier: DailyCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isDirectionalLockEnabled = true
    }
    
    func configureViewModelObserver() {
        viewModel.weatherData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.isHidden = true
                self?.tableView.isHidden = false
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let weatherData = viewModel.weatherData.value else { return cell }
        
        switch indexPath.section {
            
        case WeatherTable.Summary.rawValue:
            guard let summaryCell = tableView.dequeueReusableCell(
                withIdentifier: SummaryCell.identifier
            ) as? SummaryCell else { return cell }
            summaryCell.viewModel = viewModel.getSummaryCellViewModel(
                withWeather: weatherData
            )
            
            return summaryCell
            
        case WeatherTable.Hourly.rawValue:
            guard let hourlyCell = tableView.dequeueReusableCell(
                withIdentifier: HourlyCollectionView.identifier
            ) as? HourlyCollectionView else { return cell }
            hourlyCell.viewModel = viewModel.getHourlyCellViewModel(
                withWeather: weatherData
            )
            
            return hourlyCell
            
        case WeatherTable.Extra.rawValue:
            guard let extraCell = tableView.dequeueReusableCell(
                withIdentifier: ExtraCollectionView.identifier
            ) as? ExtraCollectionView else { return cell}
            extraCell.viewModel = viewModel.getExtraCellViewModel(
                withWeather: weatherData
            )
            
            return extraCell
            
        case WeatherTable.Daily.rawValue:
            guard let dailyCell = tableView.dequeueReusableCell(
                withIdentifier: DailyCell.identifier
            ) as? DailyCell else { return cell }
            
            let dayData = weatherData.forecast.forecastday[indexPath.row]
            dailyCell.viewModel = viewModel.getDailySectionCellViewModel(withDay: dayData)
            
            return dailyCell
            
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.getHeaderTitle(forSection: section)
    }
}

// MARK: - UITableViewDelegate

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case WeatherTable.Summary.rawValue, WeatherTable.Hourly.rawValue: heightS
        case WeatherTable.Extra.rawValue: heightL
        case WeatherTable.Daily.rawValue: heightXS
            
        default: heightS
        }
    }
}

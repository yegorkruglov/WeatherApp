//
//  CurrentLocationViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 28.09.2023.
//

import UIKit
import SnapKit

final class CurrentLocationViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableView = UITableView()
    
    private let viewModel: CurentLocationViewModelProtocol = CurentLocationViewModel()
    
    private lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        setupUI()
        configureViewModelObserver()
    }
}

private extension CurrentLocationViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
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
        
        tableView.register(SummarySection.self, forCellReuseIdentifier: SummarySection.identifier)
        tableView.register(HourlySection.self, forCellReuseIdentifier: HourlySection.identifier)
        tableView.register(ExtraSection.self, forCellReuseIdentifier: ExtraSection.identifier)
        tableView.register(DailySectionCell.self, forCellReuseIdentifier: DailySectionCell.identifier)
        
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

extension CurrentLocationViewController: UITableViewDataSource {
    
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
            
        case Table.Summary.rawValue:
            guard let summaryCell = tableView.dequeueReusableCell(
                withIdentifier: SummarySection.identifier
            ) as? SummarySection else { return cell }
            summaryCell.viewModel = viewModel.getSummaryCellViewModel(
                withWeather: weatherData
            )
            return summaryCell
            
        case Table.Hourly.rawValue:
            guard let hourlyCell = tableView.dequeueReusableCell(
                withIdentifier: HourlySection.identifier
            ) as? HourlySection else { return cell }
            hourlyCell.viewModel = viewModel.getHourlyCellViewModel(
                withWeather: weatherData
            )
            return hourlyCell
            
        case Table.Extra.rawValue:
            guard let extraCell = tableView.dequeueReusableCell(
                withIdentifier: ExtraSection.identifier
            ) as? ExtraSection else { return cell}
            extraCell.viewModel = viewModel.getExtraCellViewModel(
                withWeather: weatherData
            )
            
            return extraCell
            
        case Table.Daily.rawValue:
            guard let dailyCell = tableView.dequeueReusableCell(
                withIdentifier: DailySectionCell.identifier
            ) as? DailySectionCell else { return cell }
            
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

extension CurrentLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case Table.Summary.rawValue, Table.Hourly.rawValue: heightS
        case Table.Extra.rawValue: heightL
        case Table.Daily.rawValue: heightXS
            
        default: heightS
        }
    }
}
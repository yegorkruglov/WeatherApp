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
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        tableView.register(HourlyCell.self, forCellReuseIdentifier: HourlyCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
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
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let weatherData = viewModel.weatherData.value else { return cell }
        
        switch indexPath.section {
        case Table.Summary.rawValue:
            guard let summaryCell = tableView.dequeueReusableCell(
                withIdentifier: SummaryCell.identifier
            ) as? SummaryCell else { return cell }
            summaryCell.viewModel = viewModel.getSummaryCellViewModel(
                withWeather: weatherData
            )
            return summaryCell
            
        case Table.Hourly.rawValue:
            guard let hourlyCell = tableView.dequeueReusableCell(
                withIdentifier: HourlyCell.identifier
            ) as? HourlyCell else { return cell }
            hourlyCell.viewModel = viewModel.getHourlyCellViewModel(
                withWeather: weatherData
            )
            return hourlyCell
            
            //        case Table.Extra.rawValue:
            //        case Table.Daily.rawValue:
        default:
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension CurrentLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section < 2 ? heightS : heightM
    }
}

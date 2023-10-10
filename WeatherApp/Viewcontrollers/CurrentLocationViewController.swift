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
        
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        setupUI()
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchWeatherForLocation { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.tableView.isHidden.toggle()
        }
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
        tableView.isHidden.toggle()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
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
        guard let weatherData = viewModel.weatherData else { return cell }
        
        switch indexPath.row {
        case Table.Summary.rawValue:
            guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.identifier) as? SummaryCell else { return cell }
            summaryCell.viewModel = viewModel.getSummaryCellViewModel(withWeather: weatherData)
            return summaryCell
//        case Table.Hourly.rawValue:
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
        if indexPath.section < 2 {
            return heightS
        } else {
            return heightM
        }
    }
}

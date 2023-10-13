//
//  LocationsViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import UIKit

class LocationsViewController: UIViewController {
    
    private let viewModel: LocationsViewControllerViewModelProtocol
    
    private let tableView = UITableView()
    
    init(viewModel: LocationsViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureTableView()
        configureViewModelObserver()
    }
}

private extension LocationsViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.layer.cornerRadius = Constants.cornerRadiusM
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.insetL)
            make.verticalEdges.equalTo(self.view.safeAreaLayoutGuide.snp.verticalEdges)
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isDirectionalLockEnabled = true
    }
    
    func configureViewModelObserver() {
        viewModel.CurrentLocationWeatherData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            }
        }
    }
}

extension LocationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherData = viewModel.CurrentLocationWeatherData.value else { return UITableViewCell() }
        //        indexPath.section == LocationsTable.CurrentLocation.rawValue
        //        ? viewModel.fetchWeatherForLocationCurrentLocation()
        //        : viewModel.fetchWeatherForLocation(at: indexPath)
        
        guard let summaryCell = tableView.dequeueReusableCell(
            withIdentifier: SummaryCell.identifier
        ) as? SummaryCell else { return UITableViewCell() }
        summaryCell.viewModel = viewModel.getSummaryCellViewModel(
            withWeather: weatherData
        )
        
        return summaryCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.getHeaderTitleFor(section: section)
    }
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightS
    }
}

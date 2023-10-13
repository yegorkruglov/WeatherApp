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
        title = "Locations"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.layer.cornerRadius = Constants.cornerRadiusM
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.insetL)
            make.verticalEdges.equalTo(self.view.safeAreaLayoutGuide.snp.verticalEdges)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(goToSearchViewController)
        )
    }
    
    @objc func goToSearchViewController() {
        let searchVC = SearchViewController(viewModel: SearchViewControllerViewModel())
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        
        tableView.separatorStyle = .none
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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        summaryCell.selectedBackgroundView = backgroundView
        
        return summaryCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.getHeaderTitleForSection(number: section)
    }
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightS
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let weatherData = viewModel.CurrentLocationWeatherData.value else { return }
        navigationController?.pushViewController(WeatherViewController(viewModel: WeatherViewControllerViewModel(weatherData: weatherData)), animated: true)
    }
}

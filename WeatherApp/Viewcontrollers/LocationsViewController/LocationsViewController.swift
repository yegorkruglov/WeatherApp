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
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.updateTableView()
    }
}

private extension LocationsViewController {
    func setupUI() {
        title = "Locations"
        view.backgroundColor = .systemBackground
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(reload)
        )
    }
    
    @objc func goToSearchViewController() {
        let searchVC = SearchViewController(viewModel: SearchViewControllerViewModel())
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func reload() {
        viewModel.updateTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    func configureViewModelObserver() {
        viewModel.currentLocationWeatherData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.savedLocationsWeatherData.bind { [weak self] savedLocationsWeatherData in
            guard self?.viewModel.savedLocations.count == savedLocationsWeatherData.count else { return }
            
            DispatchQueue.main.async {
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }
}

extension LocationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(number: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard self.viewModel.savedLocations.count == self.viewModel.savedLocationsWeatherData.value.count else { return cell }
        
        guard let summaryCell = tableView.dequeueReusableCell(
            withIdentifier: SummaryCell.identifier
        ) as? SummaryCell else { return UITableViewCell() }
        
        
        guard let viewModel = viewModel.getSummaryCellViewModel(at: indexPath) else { return cell }
        
        summaryCell.viewModel = viewModel
        
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
        
        guard let viewModel = viewModel.getWeatherViewControllerViewModel(at: indexPath) else { return }
        let vc = WeatherViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

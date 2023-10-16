//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.10.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewControllerViewModelProtocol
    
    private let tableView = UITableView()
    
    private let searchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "City name, airport code"
        
        return searchController
    }()
    
    private lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    private var timer: Timer?
    
    init(viewModel: SearchViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SearchVC was released")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupSearchController()
        configureTableView()
        configureViewModelObserver()
    }
}

private extension SearchViewController {
    func setupUI() {
        title = "Search"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.layer.cornerRadius = Constants.cornerRadiusM
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.insetL)
            make.verticalEdges.equalTo(self.view.safeAreaLayoutGuide.snp.verticalEdges)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    func setupSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
    
    func configureViewModelObserver() {
        
        viewModel.searchResults.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.weatherData.bind { [weak self] weatherData in
            guard let weatherData = weatherData else { return }
            let viewModel = WeatherViewControllerViewModel(weatherData: weatherData, isCurrentLocationViewController: false)
            let weatherVC = WeatherViewController(viewModel: viewModel)
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            
            self?.navigationController?.pushViewController(weatherVC, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        
        let locationData = viewModel.getLocationData(at: indexPath)
        
        cell.viewModel = viewModel.getSearchCellViewModel(withLocation: locationData)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightXS
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        viewModel.getWeatherForLocation(at: indexPath)
        activityIndicator.startAnimating()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else { return }
            self?.viewModel.searchFor(query: searchQuery)
        }
    }
}

extension SearchViewController: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        searchController.resignFirstResponder()
        viewModel.searchBarCancelButtonClicked()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else { return }
        viewModel.searchFor(query: searchQuery)
    }
}


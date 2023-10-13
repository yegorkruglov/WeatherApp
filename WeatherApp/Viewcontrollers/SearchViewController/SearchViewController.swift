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
        configureTableView()
        configureViewModelObserver()
    }
}

private extension SearchViewController {
    func setupUI() {
        title = "Search"
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
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        
        tableView.separatorStyle = .none
    }
    
    func configureViewModelObserver() {
//        viewModel.CurrentLocationWeatherData.bind { [weak self] _ in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//                self?.tableView.isHidden = false
//            }
//        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        
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
    
    }
}


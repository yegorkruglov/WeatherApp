//
//  HourlySection.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

class HourlySection: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    private var collectionView: UICollectionView?
    
    var viewModel: HourlySectionViewModelProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = Constants.cornerRadiusM
        contentView.layer.cornerRadius = Constants.cornerRadiusM
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView?.layer.cornerRadius = Constants.cornerRadiusM
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .clear
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(
            HourlySectionCell.self,
            forCellWithReuseIdentifier: HourlySectionCell.identifier
        )
        
        contentView.addSubview(collectionView ?? UILabel())
        collectionView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HourlySection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlySectionCell.identifier, for: indexPath) as? HourlySectionCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getHourlySectionCellViewModel(at: indexPath)
        
        return cell
    }
}

extension HourlySection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: viewWidth / 4, height: viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.insetS
    }
}

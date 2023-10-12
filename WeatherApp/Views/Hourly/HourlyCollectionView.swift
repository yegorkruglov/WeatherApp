//
//  HourlyCollectionView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 04.10.2023.
//

import UIKit

final class HourlyCollectionView: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    var viewModel: HourlyCollectionViewViewModelProtocol!

    private var collectionView: UICollectionView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HourlyCollectionView {
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
            HourlyCollectionViewCell.self,
            forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier
        )
        
        contentView.addSubview(collectionView ?? UILabel())
        collectionView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HourlyCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getHourlySectionCellViewModel(at: indexPath)
        
        return cell
    }
}

extension HourlyCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: viewWidth / 4, height: viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.insetS
    }
}


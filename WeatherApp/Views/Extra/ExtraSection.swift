//
//  ExtraSection.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 03.10.2023.
//

import UIKit

final class ExtraSection: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    private var collectionView: UICollectionView?
    
    var viewModel: ExtraSectionViewModelProtocol!
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .systemPink
        layer.cornerRadius = Constants.cornerRadiusM
        contentView.layer.cornerRadius = Constants.cornerRadiusM
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView?.layer.cornerRadius = Constants.cornerRadiusM
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = .clear
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(
            ExtraSectionCell.self,
            forCellWithReuseIdentifier: ExtraSectionCell.identifier
        )
        
        contentView.addSubview(collectionView ?? UILabel())
        collectionView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ExtraSection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtraSectionCell.identifier, for: indexPath) as? ExtraSectionCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getExtraSectionCellViewModel(at: indexPath)
        
        return cell
    }
}

extension ExtraSection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: viewWidth / 2, height: viewHeight / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.insetS
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.insetS
    }
}

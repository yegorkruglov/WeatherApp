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
    
    private let itemsPerRow: CGFloat = 2
    
    var viewModel: ExtraSectionViewModelProtocol!
        
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
        guard let extraCell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtraSectionCell.identifier, for: indexPath) as? ExtraSectionCell else { return UICollectionViewCell() }
        extraCell.viewModel = viewModel.getExtraSectionCellViewModel(at: indexPath)
        
        return extraCell
    }
}

extension ExtraSection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerSection = CGFloat(viewModel.getNumberOfItems() / 2)

        let paddingSpaceWidth = Constants.insetM
        let paddingSpaceHeight = Constants.insetM * (itemsPerSection - 1)
        let availableWidth = frame.width - paddingSpaceWidth
        let availableHeight = frame.height - paddingSpaceHeight
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = availableHeight / itemsPerSection
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.insetM
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.insetM
    }
}


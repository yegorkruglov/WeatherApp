//
//  HourCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 15.05.2025.
//

import UIKit
import Combine

final class HourCell: UICollectionViewCell {
    
    // MARK: - private properties
    
    private let api: ApiProtocol = Dependencies.shared.resolve()
    private var cancellable: AnyCancellable?
    
    // MARK: - ui elements
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, conditionImageView, tempLabel])
        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - initilizaers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - overrride methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cancellable = nil
        conditionImageView.image = nil
        activityIndicator.startAnimating()
        
        tempLabel.text = nil
        timeLabel.text = nil
    }
}

// MARK: - private methods

private extension HourCell {
    
    func setup() {
        addViews()
        setupViews()
        makeConsraints()
    }
    
    func addViews() {
        contentView.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 20
    }
    
    func makeConsraints() {
        NSLayoutConstraint.activate(
            [
                conditionImageView.heightAnchor.constraint(equalToConstant: 50),
                
                activityIndicator.centerXAnchor.constraint(equalTo: conditionImageView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: conditionImageView.centerYAnchor),
                
                vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ]
        )
    }
}


// MARK: - ItemConfigurable

extension HourCell: ItemConfigurable {
    
    func configure(with item: HourlyWeather) {
        timeLabel.text = item.time
        tempLabel.text = "\(item.temperature)°"
        
        cancellable = api.getImageFor(endpoint: item.conditionImageUrl)
            .sink { _ in
                
            } receiveValue: { data in
                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.conditionImageView.image = image
                    self?.activityIndicator.stopAnimating()
                }
            }
    }
}

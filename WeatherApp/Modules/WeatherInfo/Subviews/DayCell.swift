//
//  DayCell.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 15.05.2025.
//

import UIKit
import Combine

final class DayCell: UICollectionViewCell {
    // MARK: - private properties
    
    private let api: ApiProtocol = Dependencies.shared.resolve()
    private var cancellable: AnyCancellable?
    
    // MARK: - ui elements
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    
    private lazy var condtionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                dayLabel,
                conditionImageView,
                condtionLabel,
                tempLabel
            ]
        )
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
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
        
        dayLabel.text = nil
        condtionLabel.text = nil
        tempLabel.text = nil
    }
}

// MARK: - private methods

private extension DayCell {
    
    func setup() {
        addViews()
        setupViews()
        makeConsraints()
    }
    
    func addViews() {
        [hStackView, activityIndicator].forEach { subview in
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupViews() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .systemBackground
    }
    
    func makeConsraints() {
        NSLayoutConstraint.activate(
            [
                hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                conditionImageView.heightAnchor.constraint(equalToConstant: 50),
                conditionImageView.widthAnchor.constraint(equalToConstant: 50),
                
                activityIndicator.centerXAnchor.constraint(equalTo: conditionImageView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: conditionImageView.centerYAnchor)
            ]
        )
    }
}

// MARK: - ItemConfigurable

extension DayCell: ItemConfigurable {
    func configure(with item: DailyWeather) {
        dayLabel.text = item.date
        tempLabel.text = "H: \(item.highTemperature) L: \(item.lowTemperature)"
        condtionLabel.text = item.conditionDescription
        
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

//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Egor Kruglov on 13.05.2025.
//

import UIKit
import Combine

final class ErrorView: UIView {
    
    // MARK: - publishers
    
    private(set) var reloadButtonPublisher = PassthroughSubject<Void, Never>()
    
    // MARK: - ui elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.image = UIImage(systemName: "exclamationmark.triangle")
        return imageView
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reload", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        button.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.reloadButtonPublisher.send()
                }
            ),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - initilizers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public methods
    
    func configureWith(_ error: Error) {

        guard let error = error as? NetworkError else {
            errorMessageLabel.text = "Unknown Error:/n\(error.localizedDescription)"
            return
        }
        
        errorMessageLabel.text = "Network Error:/n\(error.userDescription)"
        
    }
}

// MARK: - private methods

private extension ErrorView {
    
    func setup() {
        addViews()
        setupViews()
        makeConsraints()
    }
    
    func addViews() {
        [imageView, errorMessageLabel, reloadButton].forEach { subview in
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupViews() {
        
    }
    
    func makeConsraints() {
        NSLayoutConstraint.activate(
            [
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 200),
                imageView.heightAnchor.constraint(equalToConstant: 200),
                
                errorMessageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
                errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                reloadButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 16),
                reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        )
    }
}

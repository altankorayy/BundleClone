//
//  HomeCollectionViewCell.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubviews(imageView, sourceLabel, titleLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        sourceLabel.text = nil
        titleLabel.text = nil
    }
    
    public func configure(model: Article) {
        sourceLabel.text = model.source.name
        titleLabel.text = model.title
        guard let imageUrl = model.urlToImage else { return }
        guard let urlString = URL(string: imageUrl) else { return }
        
        ImageLoader.shared.downloadImage(urlString) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            sourceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            sourceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            sourceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 3),
            
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 3),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 3),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}

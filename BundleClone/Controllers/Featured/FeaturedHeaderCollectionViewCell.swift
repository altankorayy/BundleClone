//
//  FeaturedHeaderCollectionViewCell.swift
//  BundleClone
//
//  Created by Altan on 29.11.2023.
//

import UIKit

class FeaturedHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedHeaderCollectionViewCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    public func configure(with model: Article) {
        guard let url = model.urlToImage else { return }
        guard let urlString = URL(string: url) else { return }
        
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
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor ),
        ])
    }
}

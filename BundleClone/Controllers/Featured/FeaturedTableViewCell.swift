//
//  FeaturedTableViewCell.swift
//  BundleClone
//
//  Created by Altan on 13.11.2023.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {

    static let identifier = "FeaturedTableViewCell"
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        
        contentView.addSubviews(newsImageView, sourceLabel, titleLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImageView.image = nil
        sourceLabel.text = nil
        titleLabel.text = nil
    }
    
    public func configure(with model: Article) {
        sourceLabel.text = model.source.name
        titleLabel.text = model.title
        guard let url = model.urlToImage else { return }
        guard let urlString = URL(string: url) else { return }
        
        ImageLoader.shared.downloadImage(urlString) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            newsImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            newsImageView.heightAnchor.constraint(equalToConstant: 100),
            newsImageView.widthAnchor.constraint(equalToConstant: 100),
            
            sourceLabel.topAnchor.constraint(equalTo: newsImageView.topAnchor),
            sourceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            sourceLabel.rightAnchor.constraint(equalTo: newsImageView.leftAnchor, constant: -15),
            
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: newsImageView.leftAnchor, constant: -15),

        ])
    }
}

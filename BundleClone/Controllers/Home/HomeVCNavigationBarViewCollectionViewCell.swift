//
//  HomeVCNavigationBarViewCollectionViewCell.swift
//  BundleClone
//
//  Created by Altan on 17.12.2023.
//

import UIKit

class HomeVCNavigationBarViewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeVCNavigationBarViewCollectionViewCell"
    
    private let titleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 17 : 20, weight: .semibold)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.clear
        contentView.addSubviews(titleButton)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func setTitle(_ title: String) {
        titleButton.setTitle(title, for: .normal)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
        ])
    }
    
}

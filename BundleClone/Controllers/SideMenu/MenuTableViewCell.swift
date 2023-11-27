//
//  MenuTableViewCell.swift
//  BundleClone
//
//  Created by Altan on 27.11.2023.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    static let identifier = "MenuTableViewCell"
    
    private let newsTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 17/255, green: 33/255, blue: 45/255, alpha: 1)
        contentView.addSubview(newsTypeLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsTypeLabel.text = nil
    }
    
    public func configure(headers: String) {
        newsTypeLabel.text = headers
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            newsTypeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            newsTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
}

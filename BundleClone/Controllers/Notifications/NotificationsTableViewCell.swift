//
//  NotificationsTableViewCell.swift
//  BundleClone
//
//  Created by Altan on 13.11.2023.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    static let identifier = "NotificationsTableViewCell"
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        addSubviews(hourLabel, sourceLabel, titleLabel, dateLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hourLabel.text = nil
        sourceLabel.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
    }
    
    private func formatDate(from dateString: String, dateFormat: String) -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        
        if let date = isoDateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = dateFormat
            let formattedDate = dateFormatter.string(from: date)
            
            return formattedDate
            
        }
        return nil
    }
    
    public func configure(with model: Article) {
        sourceLabel.text = model.source.name
        titleLabel.text = model.title
        let dateString = formatDate(from: model.publishedAt, dateFormat: "dd MMMM")
        dateLabel.text = dateString
        let hourString = formatDate(from: model.publishedAt, dateFormat: "HH:mm")
        hourLabel.text = hourString
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            hourLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            hourLabel.heightAnchor.constraint(equalToConstant: 60),
            hourLabel.widthAnchor.constraint(equalToConstant: 40),
            
            sourceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            sourceLabel.leftAnchor.constraint(equalTo: hourLabel.rightAnchor, constant: 15),
            sourceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            sourceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: hourLabel.rightAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leftAnchor.constraint(equalTo: hourLabel.rightAnchor, constant: 15),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

//
//  FeaturedTableViewCell.swift
//  BundleClone
//
//  Created by Altan on 13.11.2023.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {

    static let identifier = "FeaturedTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
}

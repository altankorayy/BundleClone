//
//  Extensions.swift
//  BundleClone
//
//  Created by Altan on 13.11.2023.
//

import UIKit

extension UIScreen {
    static let darkMode = UIScreen.main.traitCollection.userInterfaceStyle == .dark
    static let lightMode = UIScreen.main.traitCollection.userInterfaceStyle == .light
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

extension UIColor {
    static let bundleColor = UIColor(red: 9/255, green: 19/255, blue: 26/255, alpha: 1)
    static let tabBarColor = UIColor(red: 13/255, green: 27/255, blue: 35/255, alpha: 1)
    
    static func setColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .light ? lightColor : darkColor
            }
        } else {
            return lightColor
        }
    }
}

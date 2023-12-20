//
//  RemoveAdsViewController.swift
//  BundleClone
//
//  Created by Altan on 17.12.2023.
//

import UIKit
import StoreKit

class RemoveAdsViewController: UIViewController {
    
    enum Product: String, CaseIterable {
        case month = "com.altankoray.month"
        case year = "com.altankoray.year"
    }
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let firstWord = "Welcome"
        let secondWord = "to"
        let attributedString = NSMutableAttributedString(string: "\(firstWord) \(secondWord)")
        let firstWordRange = NSRange(location: 0, length: firstWord.count)
        let firstWordColor = UIColor.red
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: firstWordColor, range: firstWordRange)
        label.attributedText = attributedString
        label.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 30 : 40, weight: .bold)
        return label
    }()
    
    private let premiumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bundle Premium"
        label.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 30 : 40, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let premiumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "premiumIllustration")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let addfreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AD - FREE NEWS FEED"
        label.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 14 : 24, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hide the native ads that show up in your news feed."
        label.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 13 : 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = "Click for details."
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 13 : 18, weight: .regular)
        return button
    }()
    
    private let monthlyPurchaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("₺12,99 / Month", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 13 : 16, weight: .bold)
        return button
    }()
    
    private let yearPurchaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("₺129,99 / Year", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIDevice.isiPhone ? 13 : 16, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        view.addSubviews(welcomeLabel, premiumLabel, premiumImage, addfreeLabel, descriptionLabel, detailsButton, monthlyPurchaseButton, yearPurchaseButton)
        
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        monthlyPurchaseButton.addTarget(self, action: #selector(didTapMonthlyPurchase), for: .touchUpInside)
        yearPurchaseButton.addTarget(self, action: #selector(didTapYearPurchase), for: .touchUpInside)
                
        configureConstraints()
    }
    
    @objc
    private func didTapYearPurchase() {
        let setProduct: Set<String> = [Product.year.rawValue]
        let productRequest = SKProductsRequest(productIdentifiers: setProduct)
        productRequest.delegate = self
        productRequest.start()
    }
    
    @objc
    private func didTapMonthlyPurchase() {
        if SKPaymentQueue.canMakePayments() {
            let setProduct: Set<String> = [Product.month.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: setProduct)
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    @objc
    private func didTapDetailsButton() {
        let alert = UIAlertController(title: "Information", message: "Native ads that show up in your news feed are hidden with Bundle Premium. The ads publishers display are not under our control however and cannot be hidden.", preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "Done", style: .default)
        alert.addAction(doneButton)
        
        if traitCollection.userInterfaceStyle == .dark {
            alert.overrideUserInterfaceStyle = .light
        } else {
            alert.overrideUserInterfaceStyle = .dark
        }
        
        present(alert, animated: true)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            premiumLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5),
            premiumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            premiumImage.topAnchor.constraint(equalTo: premiumLabel.bottomAnchor, constant: 10),
            premiumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            premiumImage.widthAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 250 : 300),
            premiumImage.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 250 : 300),
            
            addfreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addfreeLabel.topAnchor.constraint(equalTo: premiumImage.bottomAnchor, constant: 10),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: addfreeLabel.bottomAnchor, constant: 10),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            
            detailsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            
            monthlyPurchaseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            monthlyPurchaseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIDevice.isiPhone ? 30 : (view.frame.width/3)+30),
            monthlyPurchaseButton.heightAnchor.constraint(equalToConstant: 45),
            monthlyPurchaseButton.widthAnchor.constraint(equalToConstant: 150),
            
            yearPurchaseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            yearPurchaseButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: UIDevice.isiPhone ? -30 : -(view.frame.width/3)-30),
            yearPurchaseButton.heightAnchor.constraint(equalToConstant: 45),
            yearPurchaseButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    }

}

extension RemoveAdsViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            self.purchase(product: product)
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Purchasing product...")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("Restore product")
            case .deferred:
                print("Deferred")
            default:
                break
            }
        }
    }
    
    func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
}

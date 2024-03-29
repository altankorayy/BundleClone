//
//  DetailsViewController.swift
//  BundleClone
//
//  Created by Altan on 29.11.2023.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {
        
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: UIDevice.isiPhone ? 22 : 27, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: UIDevice.isiPhone ? 13 : 19, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: UIDevice.isiPhone ? 13 : 19, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: UIDevice.isiPhone ? 17 : 23, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let websideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GO TO WEBSIDE", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIDevice.isiPhone ? 13 : 18, weight: .regular)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Web","Reader"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.secondaryLabel.cgColor
        return segmentedControl
    }()
    
    private var model: Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        view.addSubviews(imageView, titleLabel, sourceLabel, dateLabel, descriptionLabel, websideButton, segmentedControl)
        
        websideButton.addTarget(self, action: #selector(didTapWebsideButton), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
        
        view.accessibilityIdentifier = "DetailsViewController"
        
        navigationController?.navigationBar.tintColor = .label
        
        configureNavigationBar()
                
        configureConstraints()
        
    }
    
    @objc
    private func didSelectSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            DispatchQueue.main.async { [weak self] in
                let webVC = WebViewViewController()
                guard let url = self?.model?.url else { return }
                webVC.loadWebside(url: url)
                self?.navigationController?.pushViewController(webVC, animated: true)
            }
        case 1:
            break
        default:
            break
        }
    }
    
    @objc
    private func didTapWebsideButton() {
        guard Thread.current.isMainThread else { return }
        
        guard let urlString = model?.url else { return }
        let webView = WebViewViewController()
        webView.loadWebside(url: urlString)
        navigationController?.pushViewController(webView, animated: true)
    }
    
    private func configureNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        
        navigationItem.titleView = segmentedControl
    }
    
    private func formatDate(date: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        guard let myDate = isoFormatter.date(from: date) else { return nil }
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(myDate) //returns seconds
        let elapsedMinutes = Int(elapsedTime / 60)
        let elapsedHours = Int(elapsedMinutes / 60)
        let elapsedDays = Int(elapsedHours / 24)
        
        if elapsedMinutes <= 60 {
            return "\(elapsedMinutes) Minutes before"
        } else if elapsedHours <= 24 {
            return "\(elapsedHours) Hours before"
        } else if elapsedDays == 1 {
            return "Yesterday"
        } else if elapsedDays > 1 {
            return "\(elapsedDays) Days before"
        } else {
            return "Today"
        }
    }
    
    public func configure(with model: Article) {
        self.model = model
        titleLabel.text = model.title
        sourceLabel.text = "\(model.source.name) •"
        guard let elapsedMinutes = formatDate(date: model.publishedAt) else { return }
        dateLabel.text = elapsedMinutes
        descriptionLabel.text = model.description
        
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
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 175 : 420),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),

            sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            sourceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leftAnchor.constraint(equalTo: sourceLabel.rightAnchor, constant: 5),

            descriptionLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            websideButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            websideButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            websideButton.widthAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 120 : 160),
            websideButton.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 35 : 55)
        ])
    }

}

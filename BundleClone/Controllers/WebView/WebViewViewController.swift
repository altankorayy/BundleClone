//
//  WebViewViewController.swift
//  BundleClone
//
//  Created by Altan on 30.11.2023.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        view.addSubview(webView)
        
        configureConstraints()
    }
    
    public func loadWebside(url: String) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

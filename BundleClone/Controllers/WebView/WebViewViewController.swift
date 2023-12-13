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
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = UIColor.systemRed
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        view.addSubviews(webView, progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        configureConstraints()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let newProgress = Float(self.webView.estimatedProgress)
            self.progressView.progress = newProgress
            
            if newProgress >= 1.0 {
                self.progressView.isHidden = true
            } else {
                self.progressView.isHidden = false
            }
        }
    }
    
    private func setupEstimatedProgressObserver() {
        
    }
    
    public func loadWebside(url: String) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 3),
            
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

//
//  APIEndpoint.swift
//  BundleClone
//
//  Created by Altan on 23.11.2023.
//

import Foundation

class APIEndpoint {
    
    enum APIEndpoint: String, CaseIterable {
        case topHeadlines = "top-headlines?country=us"
        case appleNews = "everything?q=apple&from=2023-11-25&to=2023-11-25&sortBy=popularity"
        case notifications = "everything?q=finance"
    }
}

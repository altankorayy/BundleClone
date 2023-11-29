//
//  APIEndpoint.swift
//  BundleClone
//
//  Created by Altan on 23.11.2023.
//

import Foundation

enum APIEndpoint: String, CaseIterable, Hashable {
    case topHeadlines = "top-headlines?country=us"
    case appleNews = "everything?q=apple&from=2023-11-25&to=2023-11-25&sortBy=popularity"
    case notifications = "everything?q=finance"
    case featured = "everything?q=bitcoin"
    case science = "everything?q=science"
}

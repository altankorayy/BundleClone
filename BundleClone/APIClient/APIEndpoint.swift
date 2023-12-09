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
    case search = "everything?q="
    case sports = "everything?q=sports"
    case gaming = "everything?q=gaming"
    case tech = "everything?q=technology"
    case politics = "everything?q=politics"
    case lifestyle = "everything?q=lifetyle"
    case cinema = "everything?q=cinema"
    case arts = "everything?q=arts"
}

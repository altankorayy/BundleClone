//
//  APIRequest.swift
//  BundleClone
//
//  Created by Altan on 23.11.2023.
//

import Foundation

class APIRequest {
    
    struct Constants {
        static let baseUrl = "https://newsapi.org/v2"
        static let topHeadlines = "top-headlines?country=us"
        static let apiKey = "446190b3c206471a90dce632251cdff2"
    }
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += Constants.topHeadlines
        string += "&apiKey="
        string += Constants.apiKey
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
}

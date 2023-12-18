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
        static let apiKey = "cea1299fe5044189baa07abfa0805658"
    }
    
    let endpoint: APIEndpoint
    let query: String?
    
    init(endpoint: APIEndpoint, query: String?) {
        self.endpoint = endpoint
        self.query = query
    }
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        string += "&apiKey="
        string += Constants.apiKey
        return string
    }
    
    private var searchUrlString: String {
        guard let query = query else { return ""}
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        string += query
        string += "&apiKey="
        string += Constants.apiKey
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public var searchUrl: URL? {
        return URL(string: searchUrlString)
    }
    
    public let httpMethod = "GET"
    
}

//
//  HomeViewModel.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import Foundation

protocol NewsTopHeadlines: AnyObject {
    func topHeadlines(_ model: [Article])
}

class HomeViewModel {
    
    var apiRequest: APIRequest?
    weak var delegate: NewsTopHeadlines?
    
    public func fetchTopHeadlines() {
        guard let request = apiRequest else {
            print("error: urlString is nil or not an APIRequest")
            return
        }
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.topHeadlines(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  FeaturedViewModel.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import Foundation

protocol FeaturedModel: AnyObject {
    func featuredModel(_ model: [Article])
}

class FeaturedViewModel {
    
    weak var delegate: FeaturedModel?
    
    public func fetchFeaturedNews() {
        let request = APIRequest(endpoint: .featured, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.featuredModel(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

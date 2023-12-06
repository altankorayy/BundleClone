//
//  ContentStoreViewModel.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import Foundation

class ContentStoreViewModel {
        
    public var queryString: String?
    
    public func search() {
        guard let query = queryString else { return }
        
        let request = APIRequest(endpoint: .search, query: query)
        APIService.shared.search(request, expecting: NewsModelResponse.self) { result in
            switch result {
            case .success(let searchModel):
                NotificationCenter.default.post(name: NSNotification.Name("didUpdateModel"), object: searchModel.articles)
            case .failure(let error):
                print(error.localizedDescription)
                print("hata burada")
            }
        }
    }
}

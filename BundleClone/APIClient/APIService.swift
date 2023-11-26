//
//  APIService.swift
//  BundleClone
//
//  Created by Altan on 23.11.2023.
//

import Foundation

class APIService {
    static let shared = APIService()
    let apiRequest = APIRequest()
    
    enum APIServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(_ request: APIRequest, expecting type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        guard let urlRequest = self.request() else {
            completion(.failure(APIServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request() -> URLRequest? {
        guard let url = apiRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.httpMethod
        return request
    }
}

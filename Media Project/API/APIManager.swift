//
//  APIManager.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import Foundation
import Alamofire

protocol URLRequestable {
    
    static var shared: URLRequestable { get }
    
    func request<T:Codable>(_ request: TMDBRequest, responseType: T.Type, completion: @escaping (Result<T, AFError>) -> Void)
}

class APIManager: URLRequestable {

    static let shared: URLRequestable = APIManager()
    
    private init() { }
    
    func request<T: Codable>(_ request: TMDBRequest, responseType: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(request).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

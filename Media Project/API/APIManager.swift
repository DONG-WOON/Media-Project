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
    
    func request<T:Codable>(_ request: TMDBRequest, responseType: T.Type, onSuccess: @escaping (T) -> Void, onFailure: @escaping (AFError) -> Void)
}

class APIManager: URLRequestable {

    static let shared: URLRequestable = APIManager()
    
    private init() { }
    
    func request<T: Codable>(_ request: TMDBRequest, responseType: T.Type, onSuccess: @escaping (T) -> Void, onFailure: @escaping (AFError) -> Void) {
        AF.request(request).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let response):
                onSuccess(response)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}

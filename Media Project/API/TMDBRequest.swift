//
//  TMDBRequest.swift
//  Media Project
//
//  Created by 서동운 on 8/11/23.
//

import Alamofire
import Foundation

enum TMDBRequest: URLRequestConvertible {
    
    enum TimeWindow: String {
        case day = "day"
        case week = "week"
    }
    
    case trending(path: TimeWindow,
                  queryItems: [URLQueryItem]? = nil)
    case credit(path: Int32,
                queryItems: [URLQueryItem]? = nil)
}

extension TMDBRequest {
    var baseURL: String { return EndPoint.baseURL }
    var method: HTTPMethod {
        switch self {
        case .trending: return .get
        case .credit: return .get
        }
    }
    
    var header: HTTPHeader {
        return HTTPHeader.authorization(bearerToken: APIKEY.tmdb_accessToken)
    }
    
    // ⭐️ domb: 현재는 movie로 해놓고 다음에는 선택가능하도록 ⭐️
    var path: String {
        switch self {
        case .trending(let timeWindow, _):
            return "/trending/movie/\(timeWindow.rawValue)"
        case .credit(let movieID, _):
            return "/movie/\(movieID)/credits"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        let defaultQueryItem = [
            URLQueryItem(name: "api_key", value: APIKEY.tmdb_Key),
            URLQueryItem(name: "language", value: "ko-KR")
        ]
        
        switch self {
        case .trending(_, let queryitems):
            guard let queryitems else { return defaultQueryItem }
            return defaultQueryItem + queryitems
        case .credit(_, let queryitems):
            guard let queryitems else { return defaultQueryItem }
            return defaultQueryItem + queryitems
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        
        url.append(path: self.path)
        url.append(queryItems: self.queryItems)
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.headers = [self.header]
        urlRequest.method = self.method
        
        return urlRequest
    }
}

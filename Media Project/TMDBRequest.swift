//
//  TMDBRequest.swift
//  Media Project
//
//  Created by 서동운 on 8/11/23.
//

import Alamofire
import Foundation

typealias TimeWindow = String
typealias MovieID = Int32

enum TMDBRequest: URLRequestConvertible {
    case trending(path: TimeWindow,
                  queryItems: [URLQueryItem]? = nil)
    case credit(path: MovieID,
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
    
    var path: String {
        switch self {
        case .trending(let timeWindow, _):
            return "/trending/all/\(timeWindow)"
        case .credit(let movieID, _):
            return "/movie/\(movieID)/credits"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        var defaultQueryItem = [URLQueryItem(name: "api_key", value: APIKEY.tmdb_Key)]
        
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

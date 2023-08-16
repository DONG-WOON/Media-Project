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
    
    case allTrending(path: TimeWindow,
                  queryItems: [URLQueryItem]? = nil)
    case movieTrending(path: TimeWindow,
                  queryItems: [URLQueryItem]? = nil)
    case tvTrending(path: TimeWindow,
                  queryItems: [URLQueryItem]? = nil)
    case movieCredit(path: Int32,
                queryItems: [URLQueryItem]? = nil)
    case tvCredit(path: Int32,
                  queryItems: [URLQueryItem]? = nil)
}

extension TMDBRequest {
    var baseURL: String { return EndPoint.baseURL }
    var method: HTTPMethod {
        switch self {
        case .allTrending: return .get
        case .movieTrending: return .get
        case .tvTrending: return .get
        case .movieCredit: return .get
        case .tvCredit: return .get
        }
    }
    
    var header: HTTPHeader {
        return HTTPHeader.authorization(bearerToken: APIKEY.tmdb_accessToken)
    }
    
    // ⭐️ domb: 현재는 movie로 해놓고 다음에는 선택가능하도록 ⭐️
    var path: String {
        switch self {
        case .allTrending(let timeWindow, _):
            return "/trending/all/\(timeWindow.rawValue)"
        case .movieTrending(let timeWindow, _):
            return "/trending/movie/\(timeWindow.rawValue)"
        case .tvTrending(let timeWindow, _):
            return "/trending/tv/\(timeWindow.rawValue)"
        case .movieCredit(let movieID, _):
            return "/movie/\(movieID)/credits"
        case .tvCredit(let movieID, _):
            return "/tv/\(movieID)/credits"
        }
        
    }
    
    var queryItems: [URLQueryItem] {
        // ⭐️ TO DO: localization을 지원한다면 language의 수정이 필요함 ⭐️
        let defaultQueryItem = [
            URLQueryItem(name: "api_key", value: APIKEY.tmdb_Key),
            URLQueryItem(name: "language", value: "ko-KR")
        ]
        
        switch self {
        case .allTrending(_, let queryitems):
            guard let queryitems else { return defaultQueryItem }
            return defaultQueryItem + queryitems
        case .movieTrending(_, let queryitems):
            guard let queryitems else { return defaultQueryItem }
            return defaultQueryItem + queryitems
        case .tvTrending(_, let queryitems):
            guard let queryitems else { return defaultQueryItem }
            return defaultQueryItem + queryitems
        case .movieCredit(_, let queryitems):
            guard let queryitems else { return defaultQueryItem }
            return defaultQueryItem + queryitems
        case .tvCredit(_, let queryitems):
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

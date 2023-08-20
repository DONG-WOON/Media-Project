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
    // Trending
    case allTrending(path: TimeWindow, queryItems: [URLQueryItem]? = nil)
    case movieTrending(path: TimeWindow, queryItems: [URLQueryItem]? = nil)
    case tvTrending(path: TimeWindow, queryItems: [URLQueryItem]? = nil)
    
    // Credit
    case movieCredit(path: Int32, queryItems: [URLQueryItem]? = nil)
    case tvCredit(path: Int32, queryItems: [URLQueryItem]? = nil)
    
    // Season
    case tvSeason(path: Int32, queryItems: [URLQueryItem]? = nil)
    case tvSeasonDetail(id: Int32, seasonNumber: Int, queryItems: [URLQueryItem]? = nil)
    
    // Similar
    case movieSimilar(path: Int32, queryItems: [URLQueryItem]? = nil)
    case tvSimilar(path: Int32, queryItems: [URLQueryItem]? = nil)
    
    // Videos
    case movieVideos(path: Int32, queryItems: [URLQueryItem]? = nil)
    case tvVideos(path: Int32, queryItems: [URLQueryItem]? = nil)
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
        case .tvSeason: return .get
        case .tvSeasonDetail: return .get
        case .movieSimilar: return .get
        case .tvSimilar: return .get
        case .movieVideos: return .get
        case .tvVideos: return .get
        }
    }
    
    var header: HTTPHeader {
        return HTTPHeader.authorization(bearerToken: APIKEY.accessToken)
    }
    
    // ⭐️ domb: 현재는 movie로 해놓고 다음에는 선택가능하도록 ⭐️
    var path: String {
        switch self {
            
            // Trending
        case .allTrending(let timeWindow, _):
            return "/trending/all/\(timeWindow.rawValue)"
        case .movieTrending(let timeWindow, _):
            return "/trending/movie/\(timeWindow.rawValue)"
        case .tvTrending(let timeWindow, _):
            return "/trending/tv/\(timeWindow.rawValue)"
            
            // Credit
        case .movieCredit(let id, _):
            return "/movie/\(id)/credits"
        case .tvCredit(let id, _):
            return "/tv/\(id)/credits"
            
            // Season
        case .tvSeason(let id, _):
            return "/tv/\(id)"
        case .tvSeasonDetail(let id,let seasonNumber, _):
            return "/tv/\(id)/season/\(seasonNumber)"
            
            // Similar
        case .movieSimilar(let id, _):
            return "/movie/\(id)/similar"
        case .tvSimilar(let id, _):
            return "/tv/\(id)/similar"
            
            // videos
        case .movieVideos(let id, _):
            return "movie/\(id)/videos"
        case .tvVideos(let id, _):
            return "tv/\(id)/videos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        // ⭐️ TO DO: localization을 지원한다면 language의 수정이 필요함 ⭐️
        let defaultQueryItem = [
            URLQueryItem(name: "api_key", value: APIKEY.key),
            URLQueryItem(name: "language", value: "ko-KR")
        ]
        
        switch self {
        case .allTrending(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
        case .movieTrending(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
        case .tvTrending(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
            
        case .movieCredit(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
        case .tvCredit(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
            
        case .tvSeason(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
        case .tvSeasonDetail(_, _, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
            
        case .movieSimilar(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
        case .tvSimilar(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
            
        case .movieVideos(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
        case .tvVideos(_, let queryItems):
            guard let queryItems else { return defaultQueryItem }
            return defaultQueryItem + queryItems
            
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

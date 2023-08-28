//
//  SceneName.swift
//  Media Project
//
//  Created by 서동운 on 8/28/23.
//

import Foundation

enum SceneName: String {
    case trending = "Trending"
    case search = "Search"
    case recommendation = "Recommendation"
    case detail = "Detail"
    
    var title: String {
        switch self {
        case .trending:
            return "인기 영화 / TV프로그램"
        case .search:
            return "검색 기능 지원"
        case .recommendation:
            return "관련 컨텐츠 추천"
        case .detail:
            return "배우 및 상세보기"
        }
    }
}

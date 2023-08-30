//
//  Responses.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import Foundation

// MARK: - Responses

struct TrendingResponse: Codable {
    let results: [Contents]
}

struct CreditResponse: Codable {
    let cast, crew: [Cast]?
}

struct VideoResponse: Codable {
    let id: Int
    let results: [Video]
}

struct SimilarResponse: Codable {
    let page: Int?
    let results: [Contents]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

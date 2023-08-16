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

//
//  Video.swift
//  Media Project
//
//  Created by 서동운 on 8/21/23.
//

import Foundation

// MARK: - Result
struct Video: Codable {
    let language, country, name, key: String
    let publishedAt, site: String
    let size: Int
    let type: String
    let official: Bool
    let id: String
    
    var thumbnailPath: URL? {
        return URL(string: "https://img.youtube.com/vi/\(key)/0.jpg")
    }

    enum CodingKeys: String, CodingKey {
        case language = "iso_639_1"
        case country = "iso_3166_1"
        case name, key
        case publishedAt = "published_at"
        case site, size, type, official, id
    }
}

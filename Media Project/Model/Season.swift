//
//  Season.swift
//  Media Project
//
//  Created by 서동운 on 8/17/23.
//

import Foundation


struct Season: Codable {
    let airDate: String?
    let episodeCount: Int?
    let id: Int?
    let identifier: String?
    let name, overview, posterPath: String?
    let seasonNumber: Int
    let voteAverage: Double
    var episodes: [Episode]?
    
    var imageURL: URL? {
        return URL(string: EndPoint.imageURL + (posterPath ?? ""))
    }
    
    
    var title: String {
        guard let episodeCount else { return "- 회"}
        return "에피소드: \(episodeCount) 회"
    }

    enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id
        case name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
        case episodes
    }
}

// MARK: - Episode
struct Episode: Codable {
    let airDate: String
    let episodeNumber: Int
    let episodeType: String?
    let id: Int
    let name, overview, productionCode: String?
    let runtime, seasonNumber, showID: Int?
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int
    let crew, guestStars: [Cast]?
    
    var imagePath: URL? {
        return URL(string: EndPoint.imageURL + (stillPath ?? ""))
    }
    var title: String {
        return "\(name ?? "") | \(episodeNumber)화"
    }
    var subTitle: String {
        return "방영일: \(airDate)"
    }

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case id
        case name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case crew
        case guestStars = "guest_stars"
    }
}

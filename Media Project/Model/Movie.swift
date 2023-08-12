//
//  Movie.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import Foundation

// MARK: - Movie

struct Movie: Codable {
    let adult: Bool
    let belongsToCollection: [Movie]?
    let backdropPath: String
    let firstAirDate: String?
    let id: Int
    let title: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    var genre: [String] {
        return genreIDS.map { genreList[$0] ?? "" }
    }
    
    let releaseDate: String?
    let voteAverage: Double
    let name, originalName: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case belongsToCollection = "belongs_to_collection"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case name
        case originalName = "original_name"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

let genreList = [
    28: "액션",
    12: "모험",
    16: "애니메이션",
    35: "코미디",
    80: "범죄",
    99: "다큐멘터리",
    18: "드라마" ,
    10751: "가족" ,
    14: "판타지" ,
    36: "역사",
    27: "공포",
    10402: "음악",
    9648: "미스터리",
    10749: "로맨스",
    878: "SF",
    10770: "TV 영화",
    53: "스릴러",
    10752: "전쟁",
    37: "서부"
]


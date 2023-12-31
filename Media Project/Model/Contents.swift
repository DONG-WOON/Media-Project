//
//  Contents.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import Foundation

// MARK: - Contents

// ⭐️ TO DO: 연산프로퍼티 추가. ⭐️

struct Contents: Codable {
    // Movie
    let adult: Bool
    let belongsToCollection: [Contents]?
    let backdropPath: String?
    let id: Int32
    let title: String?
    let originalLanguage: String
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    var mediaType: MediaType?
    let genreIDS: [Int]?
  
    // TV
    let originalName: String?
    let firstAirDate: String?
    let name: String?
    let releaseDate: String?
    let voteAverage: Double
    let numberOfEpisodes, numberOfSeasons: Int?
    let seasons: [Season]?
    
    var genreDescription: String {
        guard let genreIDS else { return String() }
        return genreIDS.map { "#" + (genreList[$0] ?? String()) }.joined(separator: " ")
    }
    
    var posterURL: URL? {
        return URL(string: EndPoint.imageURL + (posterPath ?? ""))
    }
    
    var backdropURL: URL? {
        return URL(string: EndPoint.imageURL + (backdropPath ?? ""))
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case belongsToCollection = "belongs_to_collection"
        case backdropPath = "backdrop_path"
        case id, title, name
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case seasons
    }
}

enum MediaType: String, Codable, CaseIterable {
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
    37: "서부",
    10759: "Action & Adventure",
    10762: "Kids",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi & Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War & Politics"
]

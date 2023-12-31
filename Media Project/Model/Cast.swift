//
//  Cast.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import Foundation

// ⭐️ TO DO: Cast, Crew 구분하기(protocol) ⭐️

struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department, job: String?
    
    var profileImageURL: URL? {
        return URL(string: EndPoint.imageURL + (profilePath ?? ""))
    }
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

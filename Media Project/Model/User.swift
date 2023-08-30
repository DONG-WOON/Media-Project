//
//  User.swift
//  Media Project
//
//  Created by 서동운 on 8/29/23.
//

import Foundation

struct User {
    var name: String
    var nickname: String
    var profileURL: String
    var genderPronoun: String
    var introduction: String
    var gender: Gender
    var link: String
}

enum Gender: String {
    case man = "man"
    case woman
    case none
}

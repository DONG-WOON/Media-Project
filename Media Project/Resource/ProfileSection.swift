//
//  ProfileSection.swift
//  Media Project
//
//  Created by 서동운 on 8/29/23.
//

import Foundation

enum ProfileSection: Int, CaseIterable {
    case name
    case nickname
    case genderPronoun
    case introduction
    case link
    case gender
    
    var title: String {
        switch self {
        case .name:
            return "이름"
        case .nickname:
            return "사용자 이름"
        case .genderPronoun:
            return "성별 대명사"
        case .introduction:
            return "소개"
        case .link:
            return "링크"
        case .gender:
            return "성별"
        }
    }
}

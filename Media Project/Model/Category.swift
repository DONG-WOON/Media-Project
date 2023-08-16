//
//  Category.swift
//  Media Project
//
//  Created by 서동운 on 8/16/23.
//

import Foundation

enum Category: String {
    case all
    case movie
    case tv
    
    var title: String {
        return self.rawValue.uppercased()
    }
}

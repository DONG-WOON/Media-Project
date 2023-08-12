//
//  Identifiable.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import Foundation

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

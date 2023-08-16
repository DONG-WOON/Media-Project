//
//  TMDBError.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import Foundation

enum TMDBError: Error {
    case invalid
    case notFound
    case authenticationFailed
}

func handleError(statusCode: Int) {
    
}

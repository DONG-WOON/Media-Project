//
//  PlaceholderProtocol.swift
//  Media Project
//
//  Created by 서동운 on 8/18/23.
//

import UIKit

protocol PlaceholderProtocol {
    var contentsPlaceholder: UIImage? { get }
    var personPlaceholder: UIImage? { get }
}

extension PlaceholderProtocol {
    var contentsPlaceholder: UIImage? {
        return UIImage(named: Resource.contentsPlaceholder)
    }
    var personPlaceholder: UIImage? {
        return UIImage(named: Resource.personPlaceholder)
    }
}

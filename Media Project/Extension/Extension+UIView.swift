//
//  Extension+UIView.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit

extension UIView: Identifiable {
    func rounded(radius: CGFloat = 10) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func makeShadow(radius: CGFloat = 10) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 0.7
    }
}

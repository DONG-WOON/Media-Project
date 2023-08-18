//
//  Extension+UIView.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit

extension UIView {
    
    enum Direction {
        case top
        case left
        case right
        case bottom
        case all
    }
    
    func rounded(radius: CGFloat = 10, direction: Direction) {
        self.layer.cornerRadius = radius
        switch direction {
        case .top:
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case .left:
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .right:
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        case .bottom:
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .all:
            self.layer.cornerRadius = radius
        }
    }
    
    func makeShadow(radius: CGFloat = 10) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 0.7
    }
}
extension UIView: Identifiable { }
extension UIView: PlaceholderProtocol { }

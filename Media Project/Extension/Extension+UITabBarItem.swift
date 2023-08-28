//
//  Extension+UITabBarItem.swift
//  Media Project
//
//  Created by 서동운 on 8/28/23.
//

import UIKit

extension UITabBarItem {
    convenience init(title: String, imageKey: String) {
        self.init(title: title, image: UIImage(systemName: imageKey), selectedImage: UIImage(systemName: imageKey))
    }
}

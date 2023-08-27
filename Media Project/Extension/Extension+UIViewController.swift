//
//  Extension+UIViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit

extension UIViewController: Identifiable { }
extension UIViewController: PlaceholderProtocol { }

extension UIViewController {
    func loadViewController<T: UIViewController>(type: T.Type, FromStoryboard storyboard: String = "Main") -> T? {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: T.identifier) as? T
        return vc
    }
}

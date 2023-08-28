//
//  Search.swift
//  Media Project
//
//  Created by 서동운 on 8/27/23.
//

import UIKit

class Search: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: String(describing: Search.self)))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let arrowImageView = UIImageView(image: UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(arrowImageView)

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        arrowImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(50)
            make.width.height.equalTo(50)
            make.centerX.equalTo(imageView)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(70)
        }
    }
}

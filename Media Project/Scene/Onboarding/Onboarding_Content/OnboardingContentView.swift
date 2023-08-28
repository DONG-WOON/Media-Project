//
//  OnboardingContentView.swift
//  Media Project
//
//  Created by 서동운 on 8/28/23.
//

import UIKit

class OnboardingContentView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    convenience init(sceneName: SceneName) {
        self.init()
        imageView.image = UIImage(named: sceneName.rawValue)
        titleLabel.text = sceneName.title
        
        configureViews()
        setConstraints()
    }
    
    func configureViews() {
        addSubview(titleLabel)
        addSubview(imageView)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(self)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
    }
}

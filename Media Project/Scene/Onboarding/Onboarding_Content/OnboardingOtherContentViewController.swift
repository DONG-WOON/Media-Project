//
//  OnboardingGeneralContentViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/27/23.
//

import UIKit

class OnboardingOtherContentViewController: OnboardingContentViewController {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: ImageKey.arrowRight)
        imageView.tintColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init(sceneName: SceneName) {
        super.init(nibName: nil, bundle: nil)
        
        self.mainView = OnboardingContentView(sceneName: sceneName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateImageView()
    }
    
    override func configureViews() {
        super.configureViews()
        
        view.addSubview(imageView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(70)
            
            make.centerX.equalTo(view)
            make.width.equalTo(80)
            make.height.equalTo(70)
        }
    }
}

// MARK: Animation

extension OnboardingOtherContentViewController {
    func animateImageView() {
        let movementAmount: CGFloat = 10
        
        UIView.animate(withDuration: 0.4, delay: 0.3, options: [.autoreverse, .repeat], animations: {
            self.imageView.transform = CGAffineTransform(translationX: movementAmount, y: 0)
        }, completion: nil)
    }
}

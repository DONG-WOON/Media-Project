//
//  Recommendation.swift
//  Media Project
//
//  Created by 서동운 on 8/27/23.
//

import UIKit

class Recommendation: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: String(describing: Recommendation.self)))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(.black)
        
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.rounded(radius: 20, direction: .all)
        button.addTarget(self, action: #selector(goToTabBar), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(startButton)

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        startButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(50)
            make.height.equalTo(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(70)
        }
    }
    
    @objc func goToTabBar() {
//        UserDefaults.standard.setValue(true, forKey: Resource.isAlreadyLaunched)
    
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        guard let window = sceneDelegate?.window else { return }
        
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
        
        UIView.transition(with: window,
                          duration: 0.8,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}

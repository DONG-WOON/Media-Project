//
//  OnboardingLastContentViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/27/23.
//

import UIKit

class OnboardingLastContentViewController: OnboardingContentViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.setTitle("START", for: .normal)
        button.rounded(radius: 20, direction: .all)
        button.addTarget(self, action: #selector(goToTabBar), for: .touchUpInside)
        return button
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
    }
    
    override func configureViews() {
        super.configureViews()
        
        view.addSubview(button)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(70)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
    }
    
    @objc func goToTabBar() {
        
        UserDefaults.standard.setValue(true, forKey: NameSpace.isAlreadyLaunched)
    
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

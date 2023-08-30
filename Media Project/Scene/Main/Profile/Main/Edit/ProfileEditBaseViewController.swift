//
//  ProfileEditBaseViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/30/23.
//

import UIKit

class ProfileEditBaseViewController: UIViewController {

    let mainView: LabelWithTextFieldView

    init(title: String, placeholder: String, text: String?) {
        mainView = LabelWithTextFieldView(title: title, placeholder: placeholder, text: text)
        super.init(nibName: nil, bundle: nil)
        
        mainView.textField.addTarget(self, action: #selector(doneButtonDidTapped), for: .touchUpInside)
        
        configureViews()
        setAttributes()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @objc func doneButtonDidTapped() {
        
    }
}

extension ProfileEditBaseViewController: UIConfigurable {
    
    func configureViews() {
        view.addSubview(mainView)
    }
    
    func setAttributes() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}

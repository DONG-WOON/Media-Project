//
//  ProfileEditBaseViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/30/23.
//

import UIKit

class ProfileEditBaseViewController: UIViewController {

    let mainView: LabelWithTextFieldView
    lazy var doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneButtonDidTapped))

    init(title: String, placeholder: String, text: String?) {
        mainView = LabelWithTextFieldView(title: title, placeholder: placeholder, text: text)
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.rightBarButtonItem = doneButton
        
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
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}

//
//  ProfileEditNameViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/29/23.
//

import UIKit

class ProfileEditNameViewController: ProfileEditBaseViewController {
    
    weak var delegate: DataUpdateProtocol?
    
    convenience init(text: String?) {
        self.init(title: ProfileSection.name.title, placeholder: ProfileSection.name.title, text: text)
    }
    
    override init(title: String, placeholder: String, text: String?) {
        super.init(title: title, placeholder: placeholder, text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func doneButtonDidTapped() {
        guard let text = mainView.textField.text else { return }
        delegate?.update(data: text)
        navigationController?.popViewController(animated: true)
    }
}

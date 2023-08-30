//
//  LabelWithTextFieldView.swift
//  Media Project
//
//  Created by 서동운 on 8/29/23.
//

import UIKit

final class LabelWithTextFieldView: UIView, UIConfigurable {

    private let label = UILabel()
    let textField = UITextField()
    
    convenience init(title: String, placeholder: String, text: String? = nil) {
        self.init()
        
        label.text = title
        textField.placeholder = placeholder
        textField.text = text
        
        configureViews()
        setAttributes()
        setConstraints()
    }
    
    func configureViews() {
        addSubview(label)
        addSubview(textField)
    }
    
    func setAttributes() {
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .label
        
        textField.font = .boldSystemFont(ofSize: 15)
        textField.textColor = .label
    }
    
    func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.bottom.top.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(100)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(10)
            make.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
    }
}

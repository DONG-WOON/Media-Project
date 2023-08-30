//
//  ProfileTableViewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/29/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell, UIConfigurable {
    
    var mainView: LabelWithTextFieldView!
    
    convenience init(title: String, placeholder: String) {
        self.init()
        
        mainView = LabelWithTextFieldView(title: title, placeholder: placeholder)
        
        configureViews()
        setAttributes()
        setConstraints()
    }

    func configureViews() {
        contentView.addSubview(mainView)
    }
    
    func setAttributes() {
    }
    
    func setConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func update(data: String?) {
        mainView.textField.text = data
    }
}

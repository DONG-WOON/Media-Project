//
//  ProfileImageViewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/29/23.
//

import UIKit

class ProfileImageViewCell: UITableViewCell, UIConfigurable {

    let profileImageView = UIImageView(image: UIImage(named: NameSpace.personPlaceholder))
    let avatarImageView = UIImageView(image: UIImage(named: NameSpace.personPlaceholder))
    let editButton = UIButton()
    
    lazy var stackView = UIStackView(arrangedSubviews: [profileImageView, avatarImageView])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        configureViews()
        setAttributes()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(imageURL: String?) {
       
    }
    
    func configureViews() {
        contentView.addSubview(stackView)
        contentView.addSubview(editButton)
    }
    
    func setAttributes() {
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20
        
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.rounded(radius: 40, direction: .all)
        profileImageView.makeBorder(width: 1, color: .systemGray5)
        
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = .systemGray
        avatarImageView.rounded(radius: 40, direction: .all)
        avatarImageView.makeBorder(width: 1, color: .black)
        
        editButton.setTitle("사진 또는 아바타 수정", for: .normal)
        editButton.titleLabel?.textAlignment = .center
        editButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        editButton.setTitleColor(.black, for: .normal)
    }
    
    func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(profileImageView.snp.height)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(avatarImageView.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        editButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.centerX.equalTo(stackView)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}

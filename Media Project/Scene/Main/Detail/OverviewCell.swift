//
//  OverviewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit

final class OverviewCell: UITableViewCell {
    
    var overviewSectionReload: () -> Void = { }
    
    let overviewLabel = UILabel()
    let disclosureButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
        setAttributes()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        overviewLabel.text = nil
        disclosureButton.setImage(nil, for: .normal)
    }


    @objc func disclosureButtonDidTapped() {
        overviewSectionReload()
    }
    
    
    func update(data: String?, opened: Bool = false) {
        overviewLabel.text = data
        
        if opened {
            overviewLabel.numberOfLines =  0
            let disclosureImageName = "chevron.up"
            disclosureButton.setImage(UIImage(systemName: disclosureImageName), for: .normal)
        } else {
            overviewLabel.numberOfLines =  3
            let disclosureImageName = "chevron.down"
            disclosureButton.setImage(UIImage(systemName: disclosureImageName), for: .normal)
        }
    }
}

extension OverviewCell: UIConfigurable {
    func configureViews() {
        contentView.addSubview(overviewLabel)
        contentView.addSubview(disclosureButton)
    }
    
    func setAttributes() {
        
        overviewLabel.font = .systemFont(ofSize: 14)
        
        disclosureButton.backgroundColor = .clear
        disclosureButton.tintColor = .label
        disclosureButton.addTarget(self, action: #selector(disclosureButtonDidTapped), for: .touchUpInside)
    }
    
    func setConstraints() {
        overviewLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(10)
        }
        disclosureButton.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }
    
    
}

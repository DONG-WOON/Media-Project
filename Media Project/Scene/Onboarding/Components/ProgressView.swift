//
//  ProgressView.swift
//  Media Project
//
//  Created by 서동운 on 8/27/23.
//

import UIKit

class ProgressView: UIView {
    
    private let progressBar = UIView(.black)
    private let totalStep: Int
    private let order: Int
    
    init(height: CGFloat, order: Int, of totalStep: Int) {
        self.totalStep = totalStep
        self.order = order
        
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: height)))
        
        addSubview(progressBar)
        
        self.rounded(radius: height / 2, direction: .all)
        progressBar.rounded(radius: height / 2, direction: .all)
    
        progressBar.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        progressBar.snp.makeConstraints { make in
            make.width.equalTo((self.frame.width / CGFloat(totalStep)) * CGFloat(order))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

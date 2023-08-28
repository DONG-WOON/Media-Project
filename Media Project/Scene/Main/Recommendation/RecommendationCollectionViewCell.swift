//
//  RecommendationCollectionViewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/21/23.
//

import UIKit
import Kingfisher

class RecommendationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(data: Video) {
        titleLabel.text = data.name
        imageView.kf.setImage(with: data.thumbnailPath, placeholder: contentsPlaceholder)
    }
    
    func update(data: Contents) {
        titleLabel.text = data.name
        imageView.kf.setImage(with: data.posterURL, placeholder: contentsPlaceholder)
    }
}

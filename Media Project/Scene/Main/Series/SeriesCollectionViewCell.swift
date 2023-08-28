//
//  SeriesCollectionViewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/16/23.
//

import UIKit
import Kingfisher

class SeriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        imageView.image = nil
        overviewLabel.text = nil
    }
    
    func update(data: Episode?) {
        guard let data else { return }
        imageView.kf.setImage(with: data.imagePath, placeholder: contentsPlaceholder)
        titleLabel.text = data.title
        overviewLabel.text = data.subTitle
    }
}

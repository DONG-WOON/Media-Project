//
//  TMDBContentsTableViewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit
import Kingfisher

final class TMDBContentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var contentsBackground: UIView!
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentsImageView.rounded(direction: .top)
        contentsBackground.rounded(direction: .all)
        contentsBackground.makeShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.contentsImageView.image = nil
        self.dateLabel.text = nil
        self.titleLabel.text = nil
        self.overviewLabel.text = nil
        
    }
    
    func update(data: Contents) {
        self.categoryLabel.text = data.genreDescription
        self.contentsImageView.kf.setImage(with: data.backdropURL, placeholder: contentsPlaceholder)
        self.dateLabel.text = data.releaseDate ?? data.firstAirDate
        self.titleLabel.text = data.title ?? data.name
        self.overviewLabel.text = data.overview
    }
}

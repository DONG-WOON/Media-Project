//
//  TMDBContentsTableViewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit
import Kingfisher

final class TMDBContentsTableViewCell: UITableViewCell {
    
    //
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    // contents
    @IBOutlet weak var contentsBackground: UIView!
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentsBackground.rounded()
        contentsBackground.makeShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.contentsImageView.image = nil
        self.dateLabel.text = nil
        self.titleLabel.text = nil
        self.overviewLabel.text = nil
        
    }
    
    func update(data: Movie) {
        self.categoryLabel.text = data.genre.map {"#\($0)" }.joined(separator: "  ")
        self.contentsImageView.kf.setImage(with: URL(string: EndPoint.imageURL+data.backdropPath))
        self.dateLabel.text = data.releaseDate
        self.titleLabel.text = data.title
        self.overviewLabel.text = data.overview
    }
}

//
//  HeaderSeriesCollectionReusableView.swift
//  Media Project
//
//  Created by 서동운 on 8/16/23.
//

import UIKit
import Kingfisher

class HeaderSeriesCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        episodeCountLabel.textColor = .darkGray
    }
    
    func update(data: Season) {
        posterImageView.kf.setImage(with: URL(string: EndPoint.imageURL + data.posterPath))
        titleLabel.text = data.name
        episodeCountLabel.text = "에피소드: \(data.episodeCount) 회"
    }
    
}

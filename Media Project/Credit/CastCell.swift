//
//  CastCell.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit
import Kingfisher

final class CastCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(data: Cast) {
        profileImageView.kf.setImage(with: URL(string: EndPoint.imageURL + (data.profilePath ?? "")))
        nameLabel.text = data.originalName
        characterLabel.text = data.character
    }
}

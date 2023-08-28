//
//  OverviewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit

final class OverviewCell: UITableViewCell {
    
    var overviewSectionReload: () -> Void = { }
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var disclosureButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        overviewLabel.text = nil
        disclosureButton.setImage(nil, for: .normal)
    }

    @IBAction func disclosureButtonDidTapped(_ sender: UIButton) {
        
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

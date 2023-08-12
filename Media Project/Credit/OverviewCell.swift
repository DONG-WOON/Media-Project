//
//  OverviewCell.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit

final class OverviewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func disclosureButtonDidTapped(_ sender: UIButton) {
    }
    
    
    func update(data: String?) {
        overviewLabel.text = data
    }
}

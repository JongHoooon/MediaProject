//
//  RelatedTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/20.
//

import UIKit

class RelatedTableViewCell: BaseTableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    func configureCell(row relatedVideoInfo: RelatedVideoInfo) {
        nameLabel.text = relatedVideoInfo.name
        infoLabel.text = relatedVideoInfo.subInfoText
    }
}

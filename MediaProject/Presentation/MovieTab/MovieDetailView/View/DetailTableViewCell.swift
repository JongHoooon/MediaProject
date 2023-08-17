//
//  DetailTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
    }
    
    func configureCell(with row: Cast) {
        let profileImageURL = VideoAPI.fetchImage(url: row.profilePath).url
        profileImageView.fetchImage(
            urlString: profileImageURL,
            placeholder: MPImage.PlaceholderImage.person,
            backgroundColorForError: .systemGray5
        )
        nameLabel.text = row.name
        infoLabel.text = row.character
    }
}

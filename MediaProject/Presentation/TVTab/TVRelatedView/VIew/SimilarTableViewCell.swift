//
//  SimilarTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/20.
//

import UIKit

class SimilarTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var voteLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }
    
    func configureCell(row video: Video) {
        let posterURL = VideoAPI.fetchImage(url: video.posterPath).url
        posterImageView.fetchImage(
            urlString: posterURL,
            placeholder: MPImage.PlaceholderImage.movie,
            backgroundColorForError: .systemGray5
        )
        titleLabel.text = video.title
        voteLabel.text = "⭐️ " + (video.voteAverageText ?? "")
    }
}

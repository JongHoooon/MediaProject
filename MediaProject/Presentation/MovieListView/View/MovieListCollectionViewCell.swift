//
//  MovieListCollectionViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var contentsBackgroundView: UIView!
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var voteLabel: PaddingLabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentsBackgroundView.layer.cornerRadius = 8.0
        contentsBackgroundView.clipsToBounds = true
        
        shadowView.layer.cornerRadius = 8.0
        shadowView.layer.borderColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 8.0
        
        separatorView.backgroundColor = .label
    }

}

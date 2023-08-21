//
//  MovieListCollectionViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

import Alamofire

final class MovieListCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    // MARK: - UI
    
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var contentsBackgroundView: UIView!
    @IBOutlet private var backdropImageView: UIImageView!
    @IBOutlet private var voteLabel: PaddingLabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet private var castsLabel: UILabel!
    @IBOutlet private var separatorView: UIView!
    @IBOutlet private var shadowView: UIView!
    
    // MARK: - Lifecycle
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backdropImageView.image = nil
    }

    func configureCell(with item: Video) {
        let backdropURL = VideoAPI.fetchImage(url: item.backdropPath).url
        backdropImageView.fetchImage(
            urlString: backdropURL,
            placeholder: MPImage.PlaceholderImage.movie
        )
        dateLabel.text = item.releaseDateText
        genreLabel.text = genre.movieGenre[item.genreIDS[0], default: "Movie"]
        titleLabel.text = item.title
        originalTitleLabel.text = item.originalTitle
        voteLabel.text = item.voteAverageText
        configureCastsLabel(id: item.id)
    }
}

private extension MovieListCollectionViewCell {
    func configureCastsLabel(id: Int) {
        Task {
            do {
                let creditResponseDTO = try await MovieManager.shared.callRequest(
                    of: CreditResponseDTO.self,
                    movieAPI: .fetchCredits(id: id)
                )
                let casts = creditResponseDTO.toCasts()
                let castsText = casts.prefix(4)
                    .map { $0.name }
                    .joined(separator: ", ")
                castsLabel.text = castsText
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

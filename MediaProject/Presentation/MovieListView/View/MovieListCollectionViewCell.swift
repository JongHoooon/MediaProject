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
    
    private let genres: [Int: String] = [
        28: "Actrion",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
    // MARK: - UI
    
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var contentsBackgroundView: UIView!
    @IBOutlet private var backdropImageView: UIImageView!
    @IBOutlet private var voteLabel: PaddingLabel!
    @IBOutlet private var titleLabel: UILabel!
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

    func configureCell(with item: Movie) {
        let backdropURL = MovieAPI.fetchImage(url: item.backdropPath).url
        backdropImageView.fetchImage(
            urlString: backdropURL,
            placeholder: MPImage.PlaceholderImage.movie
        )
        let releaseDateResponse = item.releaseDate.split(separator: "-")
        let year = releaseDateResponse[0]
        let month = releaseDateResponse[1]
        let day = releaseDateResponse[2]
        dateLabel.text = [
            month,
            day,
            year
        ].map { String($0 ?? "") }
         .joined(separator: "/")
        genreLabel.text = genres[item.genreIDS[0], default: "Movie"]
        titleLabel.text = item.title
        voteLabel.text = String(format: "%.1f", item.voteAverage)
        
        MovieManager.shared
            .callRequest(
                movieAPI: .fetchCredits(id: item.id),
                completionHandler: { [weak self] (result: Result<CreditResponseDTO, AFError>) in
                    switch result {
                    case let .success(creditResponse):
                        if let castDTOs = creditResponse.cast {
                            let casts = castDTOs.map { $0.toCast() }
                            let castsText = casts.prefix(4)
                                .map { $0.name }
                                .joined(separator: ", ")

                            self?.castsLabel.text = castsText
                        }
                        break
                    case let .failure(error):
                        print(error.errorDescription ?? "알 수 없는 오류입니다.")
                        break
                    }
                }
            )
    }
}

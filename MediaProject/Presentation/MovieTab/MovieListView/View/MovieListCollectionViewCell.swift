//
//  MovieListCollectionViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

import Alamofire

final class MovieListCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Properties
    
    // MARK: - UI
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0)
        label.textColor = .systemGray
        label.text = "12/10/2020"
        return label
    }()
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17.0)
        label.textColor = .label
        label.text = "#Mystery"
        return label
    }()
    private let contentsBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        return view
    }()
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let voteLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .systemPurple
        label.textColor = .white
        label.text = "평점"
        label.font = .systemFont(ofSize: 13.0)
        return label
    }()
    private let voteScoreLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .white
        label.textColor = .systemPurple
        label.font = .systemFont(ofSize: 13.0)
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17.0)
        label.textColor = .label
        return label
    }()
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14.0)
        label.textColor = .systemGray
        return label
    }()
    private let castsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15.0)
        label.textColor = .systemGray
        return label
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    private let seeMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "자세히 보기"
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    private let seeMoreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .label
        return imageView
    }()
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 8.0
        return view
    }()
    
    // MARK: - Lifecycle
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
        voteScoreLabel.text = item.voteAverageText
        configureCastsLabel(id: item.id)
    }
    
    override func configureView() {
        
        [
            backdropImageView,
            voteLabel, voteScoreLabel,
            titleLabel, originalTitleLabel,
            castsLabel,
            separatorView,
            seeMoreLabel, seeMoreImageView
        ].forEach { contentsBackgroundView.addSubview($0) }
        
        shadowView.addSubview(contentsBackgroundView)
        
        [
            dateLabel,
            genreLabel,
            shadowView,
        ].forEach { contentView.addSubview($0) }
        
        dateLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(16.0)
            $0.height.equalTo(13.0)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
            $0.height.equalTo(17.0)
        }
        
        shadowView.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(16.0)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16.0)
        }
        
        contentsBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backdropImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top).offset(-8.0)
        }
        backdropImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        backdropImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        voteLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(backdropImageView.snp.bottom).offset(-16.0)
        }
        voteScoreLabel.snp.makeConstraints {
            $0.centerY.equalTo(voteLabel)
            $0.leading.equalTo(voteLabel.snp.trailing)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalTo(originalTitleLabel.snp.leading).offset(-8.0)
            $0.bottom.equalTo(castsLabel.snp.top).offset(-4.0)
        }
        originalTitleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalTo(titleLabel)
        }
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        originalTitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        originalTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        castsLabel.snp.makeConstraints {
            $0.bottom.equalTo(separatorView.snp.top).offset(-16.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16.0)
            $0.height.equalTo(1.0)
            $0.bottom.equalTo(seeMoreLabel.snp.top).offset(-16.0)
        }
        
        seeMoreLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16.0)
        }
        seeMoreImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16.0)
        }
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

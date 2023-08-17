//
//  MovieDetailViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

import Alamofire

final class MovieDetailViewController: UIViewController,
                                       StoryboardInstantiableProtocol,
                                       AlertableProtocol {
    
    // MARK: - Properties
    
    var backdropPath: String!
    var posterPath: String!
    var movieTitle: String!
    var movieID: Int!
    var overview: String!
    private var casts: [Cast] = []
    
    private var isViewMoreButtonTapped = false
    lazy var viewMoreButtonTapped: ((Bool) -> Void) = { [weak self] tapped in
        self?.isViewMoreButtonTapped = tapped
        self?.detailTableView.reloadRows(
            at: [IndexPath(row: 0, section: 0)],
            with: .automatic
        )
    }
    
    // MARK: - UI
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var backdropImageView: UIImageView!
    @IBOutlet private var detailTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "출연/제작"
        titleLabel.text = movieTitle
        configureImageViews()
        fetchCredits(id: movieID)
        
        registerCell()
        configureTableView()
    }
}

// MARK: - Table View

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return casts.count + 1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let infoCell = tableView.dequeueReusableCell(
                withIdentifier: InfoTableViewCell.identifier,
                for: indexPath
            ) as? InfoTableViewCell else { return UITableViewCell() }
            
            infoCell.isViewMoreButtonTapped = isViewMoreButtonTapped
            infoCell.viewMoreButtonTapped = viewMoreButtonTapped
            infoCell.overview = overview
            return infoCell
        default:
            guard let castCell = tableView.dequeueReusableCell(
                withIdentifier: DetailTableViewCell.identifier,
                for: indexPath
            ) as? DetailTableViewCell else { return UITableViewCell() }
            
            let row = casts[indexPath.row-1]
            castCell.configureCell(with: row)
            return castCell
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension MovieDetailViewController {
    func registerCell() {
        let infoNib = UINib(
            nibName: InfoTableViewCell.identifier,
            bundle: nil
        )
        detailTableView.register(
            infoNib,
            forCellReuseIdentifier: InfoTableViewCell.identifier
        )
        let castNib = UINib(
            nibName: DetailTableViewCell.identifier,
            bundle: nil
        )
        detailTableView.register(
            castNib,
            forCellReuseIdentifier: DetailTableViewCell.identifier
        )
    }
    
    func configureTableView() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
}

// MARK: - Private Method

private extension MovieDetailViewController {
    
    func configureImageViews() {
        let backdropURL = VideoAPI.fetchImage(url: backdropPath).url
        let posterURL = VideoAPI.fetchImage(url: posterPath).url
        
        backdropImageView.fetchImage(
            urlString: backdropURL,
            placeholder: MPImage.PlaceholderImage.movie
        )
        posterImageView.fetchImage(
            urlString: posterURL,
            placeholder: MPImage.PlaceholderImage.movie
        )
    }
        
    func fetchCredits(id: Int) {
        MovieManager.shared.callRequest(
            movieAPI: .fetchCredits(id: id),
            completionHandler: { [weak self] (result: Result<CreditResponseDTO, AFError>) in
                switch result {
                case let .success(creditResponseDTO):
                    if let castDTOs = creditResponseDTO.cast {
                        self?.casts = castDTOs.map { $0.toCast() }
                        self?.detailTableView.reloadData()
                    }
                case let .failure(error):
                    self?.presentAFError(error: error)
                }
            }
        )
    }
}

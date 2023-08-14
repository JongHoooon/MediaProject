//
//  MovieDetailViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

final class MovieDetailViewController: UIViewController,
                                       StoryboardInstantiableProtocol,
                                       AlertableProtocol {
    
    // MARK: - Properties
    
    var backdropPath: String!
    var posterPath: String!
    var movieTitle: String!
    var movieID: Int!
    private var casts: [Cast] = []
    
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
        
        detailTableView.rowHeight = 80.0
        registerCell()
        configureTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        backdropImageView.image = nil
        posterImageView.image = nil
    }
}

// MARK: - Table View

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return casts.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailTableViewCell.identifier,
            for: indexPath
        ) as? DetailTableViewCell else { return UITableViewCell() }
        
        let row = casts[indexPath.row]
        cell.configureCell(with: row)
        
        return cell
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
        let nib = UINib(
            nibName: DetailTableViewCell.identifier,
            bundle: nil
        )
        detailTableView.register(
            nib,
            forCellReuseIdentifier: DetailTableViewCell.identifier
        )
    }
    
    func configureTableView() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
}

private extension MovieDetailViewController {
    
    func configureImageViews() {
        let backdropURL = MovieAPI.fetchImage(url: backdropPath).url
        let posterURL = MovieAPI.fetchImage(url: posterPath).url
        
        backdropImageView.fetchImage(
            urlString: backdropURL,
            placeholder: MPImage.Placeholder.movie
        )
        posterImageView.fetchImage(
            urlString: posterURL,
            placeholder: MPImage.Placeholder.movie
        )
    }
        
    func fetchCredits(id: Int) {
        MovieManager.shared.callRequest(
            movieAPI: .fetchCredits(id: id),
            completionHandler: { [weak self] (creditResponse: CreditResponseDTO) in
                if let castDTOs = creditResponse.cast {
                    self?.casts = castDTOs.map { $0.toCast() }
                    self?.detailTableView.reloadData()
                }
            },
            errrorHandler: { [weak self] error in
                self?.presentAFError(error: error)
            })
    }
}

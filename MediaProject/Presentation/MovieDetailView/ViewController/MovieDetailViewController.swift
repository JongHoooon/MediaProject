//
//  MovieDetailViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

final class MovieDetailViewController: UIViewController,
                                       StoryboardInstantiableProtocol {
    
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
        MovieAPI.fetchImage(url: backdropPath).request
            .responseData(completionHandler: { [weak self] response in
                switch response.result {
                case let .success(data):
                    self?.backdropImageView.image = UIImage(data: data)
                case let .failure(error):
                    print(error)
                }
            })
        
        MovieAPI.fetchImage(url: posterPath).request
            .responseData(completionHandler: { [weak self] response in
                switch response.result {
                case let .success(data):
                    self?.posterImageView.image = UIImage(data: data)
                case let .failure(error):
                    print(error)
                }
            })
    }
        
    func fetchCredits(id: Int) {
        MovieAPI.fetchCredits(id: id).request
            .responseDecodable(
                of: CreditResponse.self,
                completionHandler: { [weak self] response in
                    switch response.result {
                    case let .success(value):
                        print(value)
                        if let casts = value.cast {
                            self?.casts = casts
                            self?.detailTableView.reloadData()
                        }
                        
                    case let .failure(error):
                        print(error)
                    }
                })
    }
}

//
//  MovieListViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/13.
//

import UIKit

import Alamofire

final class MovieListViewController: UIViewController,
                                     StoryboardInstantiableProtocol,
                                     AlertableProtocol {
    
    // MARK: - Properties
    
    private var movies: [Video] = []
    
    // MARK: - UI
    
    @IBOutlet private var movieListCollectionView: VideoListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        navigationItem.title = "영화 리스트"
        navigationItem.backButtonTitle = ""
        
        fetchMovieList()
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return movies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let item = movies[indexPath.row]
        cell.configureCell(with: item)
        
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let item = movies[indexPath.row]
        
        let vc = MovieDetailViewController.instantiateViewController()
        vc.movieID = item.id
        vc.backdropPath = item.backdropPath
        vc.posterPath = item.posterPath
        vc.movieTitle = item.title
        vc.overview = item.overview
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension MovieListViewController {
    
    func configureCollectionView() {
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
    }
    
    func fetchMovieList() {
        Task {
            do {
                let trendListResponseDTO = try await MovieManager.shared.callRequest(
                    of: TrendListResponseDTO.self,
                    movieAPI: .fetchTrendingVideo(type: .movie)
                )
                let videos = trendListResponseDTO.toVideos()
                movies = videos
                movieListCollectionView.reloadData()
            } catch {
                presentAFError(error: error)
            }
        }
    }
}

//
//  MovieListViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/13.
//

import UIKit

import Alamofire

final class MovieListViewController: BaseViewController,
                                     StoryboardInstantiableProtocol,
                                     AlertableProtocol {
    
    // MARK: - Properties
    
    private var movies: [Video] = []
    private let mainView = MovieListView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieList()
        if !UserDefaults.standard.bool(forKey: "isFirst") {
            showIntroView()
        }
    }
    
    override func configureView() {
        super.configureView()
        configureCollectionView()
        configureNavigationBar()
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
        
        
        
        let item = movies[indexPath.row]
        
        
        switch item.mediaType {
        case .movie:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieListCollectionViewCell.identifier,
                for: indexPath
            ) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(with: item)
            return cell
            
        case .tv:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TVListCollectionViewCell.identifier,
                for: indexPath
            ) as? TVListCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(with: item)
            return cell
            
        default:
            return UICollectionViewCell()
        }
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
    
    func configureNavigationBar() {
        navigationItem.title = "영화 리스트"
        navigationItem.backButtonTitle = ""
    }
    
    func configureCollectionView() {
        mainView.movieListCollectionView.delegate = self
        mainView.movieListCollectionView.dataSource = self
    }
    
    func fetchMovieList() {
        Task {
            do {
                let trendListResponseDTO = try await MovieManager.shared.callRequest(
                    of: TrendListResponseDTO.self,
                    movieAPI: .fetchTrendingVideo(type: .all)
                )
                let videos = trendListResponseDTO.toVideos()
                movies = videos
                mainView.movieListCollectionView.reloadData()
            } catch {
                presentAFError(error: error)
            }
        }
    }
    
    func showIntroView() {
        UserDefaults.standard.set(true, forKey: "isFirst")
        let vc = IntroPageViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
}

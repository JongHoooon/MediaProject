//
//  MovieListViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/13.
//

import UIKit

final class MovieListViewController: UIViewController,
                                     StoryboardInstantiableProtocol,
                                     AlertableProtocol {
    
    // MARK: - Properties
    
    private var movies: [Movie] = []
    private var casts: [[Cast]] = []
    
    // MARK: - UI
    
    @IBOutlet private var movieListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configureCollectionView()
        configureCollectionViewLayout()
        
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
    
    func registerCell() {
        let nib = UINib(
            nibName: MovieListCollectionViewCell.identifier,
            bundle: nil
        )
        movieListCollectionView.register(
            nib,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        )
    }
    
    func configureCollectionView() {
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let defaultInset = 16.0
        let smallInset = 4.0
        let dateLabelHeight = 13.0
        let castLabelHeight = 15.0
        let titleLabelHeight = 17.0
        let width = UIScreen.main.bounds.width
        let height = defaultInset +
            dateLabelHeight +
            smallInset +
            titleLabelHeight +
            smallInset +
            castLabelHeight +
            defaultInset +
            defaultInset +
            width +
            defaultInset
        layout.itemSize = CGSize(
            width: width,
            height: height
        )
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 16.0,
            right: 0
        )
        layout.minimumLineSpacing = 16.0
        
        movieListCollectionView.collectionViewLayout = layout
    }
    
}

private extension MovieListViewController {
    func fetchMovieList() {
        MovieManager.shared.callRequest(
            movieAPI: .fetchMovieList,
            completionHandler: { [weak self] (movieListResponse: MovieListResponseDTO) in
                if let movieDTOs = movieListResponse.movies {
                    let movies = movieDTOs.map { $0.toMovie() }
                    self?.movies = movies
                    self?.movieListCollectionView.reloadData()
                }
            },
            errrorHandler: { [weak self] error in
                self?.presentAFError(error: error)
            }
        )
    }
    
}

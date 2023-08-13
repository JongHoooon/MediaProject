//
//  MovieListViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/13.
//

import UIKit

final class MovieListViewController: UIViewController,
                                     StoryboardInstantiableProtocol {
    
    // MARK: - Properties
    
    private var movies: [Movie] = []
    
    // MARK: - UI
    
    @IBOutlet private var movieListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configureCollectionView()
        configureCollectionViewLayout()
        
        navigationItem.title = "영화 리스트"
        
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
        let titleLabelHeight = 17.0
        let width = UIScreen.main.bounds.width
        let height = defaultInset +
        dateLabelHeight +
        smallInset +
        titleLabelHeight +
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
        MovieAPI.fetchMovieList.request
            .responseDecodable(
                of: MovieListResponse.self,
                completionHandler: { [weak self] response in
                                        
                    switch response.result {
                    case let .success(value):
                        if let movies = value.movies {
                            self?.movies = movies
                            self?.movieListCollectionView.reloadData()
                        }
                        
                        break
                    case let .failure(error):
                        print(error)
                    }
                }
            )
    }
}

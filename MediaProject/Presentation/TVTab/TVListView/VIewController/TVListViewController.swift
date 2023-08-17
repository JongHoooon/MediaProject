//
//  TVListViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/17.
//

import UIKit

import Alamofire

final class TVListViewController: UIViewController,
                                     StoryboardInstantiableProtocol,
                                     AlertableProtocol {
    
    // MARK: - Properties
    
    private var tvSeriesList: [Video] = []
    
    // MARK: - UI
    
    @IBOutlet private var tvListCollectionView: UICollectionView!
    
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

extension TVListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return tvSeriesList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let item = tvSeriesList[indexPath.row]
        cell.configureCell(with: item)
        
        return cell
    }
}

extension TVListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let item = tvSeriesList[indexPath.row]
        
        let vc = MovieDetailViewController.instantiateViewController()
        vc.movieID = item.id
        vc.backdropPath = item.backdropPath
        vc.posterPath = item.posterPath
        vc.movieTitle = item.title
        vc.overview = item.overview
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension TVListViewController {
    
    func registerCell() {
        let nib = UINib(
            nibName: MovieListCollectionViewCell.identifier,
            bundle: nil
        )
        tvListCollectionView.register(
            nib,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        )
    }
    
    func configureCollectionView() {
        tvListCollectionView.delegate = self
        tvListCollectionView.dataSource = self
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
        
        tvListCollectionView.collectionViewLayout = layout
    }
    
    func fetchMovieList() {

    }
}

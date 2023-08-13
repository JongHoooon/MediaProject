//
//  MovieListViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/13.
//

import UIKit

final class MovieListViewController: UIViewController,
                                     StoryboardInstantiableProtocol {
    
    
    @IBOutlet var movieListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configureCollectionView()
        configureCollectionViewLayout()
        
        navigationItem.title = "영화 리스트"
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
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

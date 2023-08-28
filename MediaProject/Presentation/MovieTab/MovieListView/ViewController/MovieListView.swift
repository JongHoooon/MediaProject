//
//  MovieListView.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

import SnapKit

final class MovieListView: BaseView {
    
    let movieListCollectionView: VideoListCollectionView = {
        let collectionView = VideoListCollectionView()
        return collectionView
    }()
    
    override func configureView() {
        addSubview(movieListCollectionView)
    }
    
    override func setConstraints() {
        movieListCollectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

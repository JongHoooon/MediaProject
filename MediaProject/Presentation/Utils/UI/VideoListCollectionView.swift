//
//  VideoListCollectionView.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/18.
//

import UIKit

final class VideoListCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        registerCell()
        configureCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerCell()
        configureCollectionViewLayout()
    }
}

extension VideoListCollectionView {
    func registerCell() {
        let nib = UINib(
            nibName: MovieListCollectionViewCell.identifier,
            bundle: nil
        )
        register(
            nib,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        )
        register(
            TVListCollectionViewCell.self,
            forCellWithReuseIdentifier: TVListCollectionViewCell.identifier
        )
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
        
        collectionViewLayout = layout
    }
}

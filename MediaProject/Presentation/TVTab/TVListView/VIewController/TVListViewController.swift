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
    
    @IBOutlet private var tvListCollectionView: VideoListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
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
        
        let vc = TVDetailViewController.instantiateViewController()
        vc.id = item.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension TVListViewController {
    
    func configureCollectionView() {
        tvListCollectionView.delegate = self
        tvListCollectionView.dataSource = self
    }
    
    func fetchMovieList() {
        Task {
            do {
                let trendListResponseDTO = try await MovieManager.shared.callRequest(
                    of: TrendListResponseDTO.self,
                    movieAPI: .fetchTrendingVideo(type: .tv)
                )
                let videos = trendListResponseDTO.toVideos()
                tvSeriesList = videos
                tvListCollectionView.reloadData()
            } catch {
                presentAFError(error: error)
            }
        }
    }
}

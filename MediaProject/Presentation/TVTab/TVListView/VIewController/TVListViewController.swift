//
//  TVListViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/17.
//

import UIKit

import Alamofire

final class TVListViewController: BaseViewController,
                                  StoryboardInstantiableProtocol,
                                  AlertableProtocol {
    
    // MARK: - Properties
    
    private var tvSeriesList: [Video] = []
    
    // MARK: - UI
    
    @IBOutlet private var tvListCollectionView: VideoListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieList()
    }
    
    override func configureView() {
        super.configureView()
        configureCollectionView()
        navigationItem.title = "TV 리스트"
        navigationItem.backButtonTitle = ""
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
        
        let vc = TVRelatedViewController.instantiateViewController()
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
//        Task {
//            do {
//                let trendListResponseDTO = try await MovieManager.shared.callRequest(
//                    of: TrendListResponseDTO.self,
//                    movieAPI: .fetchTrendingVideo(type: .tv)
//                )
//                let videos = trendListResponseDTO.toVideos()
//                tvSeriesList = videos
//                tvListCollectionView.reloadData()
//            } catch {
//                presentAFError(error: error)
//            }
//        }
        
        let url = URL(string: "https://api.themoviedb.org/3/trending/tv/week")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(APIKey.authorization)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { [weak self] data, response, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        self?.presentSimpleAlert(message: error.localizedDescription)
                        return
                    }
                    if let httpResponse = response as? HTTPURLResponse,
                       !(200..<300 ~= httpResponse.statusCode) {
                        self?.presentSimpleAlert(message: "Bad Status Code")
                    }
                    guard let data = data else {
                        self?.presentSimpleAlert(message: "No Data")
                        return
                    }
                    
                    do {
                        let value = try JSONDecoder().decode(
                            TrendListResponseDTO.self,
                            from: data
                        )
                        self?.tvSeriesList = value.toVideos()
                        self?.tvListCollectionView.reloadData()
                    } catch {
                        self?.presentSimpleAlert(message: "Decoding Error")
                    }
                }
            }
        )
        .resume()
    }
}

//
//  TVDetailViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/18.
//

import UIKit

import Alamofire

final class TVDetailViewController: UIViewController,
                                    StoryboardInstantiableProtocol,
                                    AlertableProtocol {
    
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Private Method

private extension TVDetailViewController {
    
    func fetchTVDetail(id: Int) {
        
//        MovieManager.shared.callRequest(
//            movieAPI: .fetchTVDetails(id: id),
//            completionHandler: { [weak self] (result: Result<TVSeriesDetailDTO, AFError>) in
//                switch result {
//                case let .success(value):
//                    break
//                case let .failure(error):
//
//                    break
//                }
//            })
        Task {
            
            do {
                let tvSeriesDetailDTO = try await MovieManager.shared.callRequest(
                    of: TVSeriesDetailDTO.self,
                    movieAPI: .fetchTVDetails(id: id)
                )
                let tvDetail = tvSeriesDetailDTO.toTVDetail()
                
            } catch {
                presentAFError(error: error)
            }
        }
    }
}



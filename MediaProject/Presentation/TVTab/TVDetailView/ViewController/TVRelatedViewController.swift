//
//  TVRelatedViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/18.
//

import UIKit

import Alamofire

final class TVRelatedViewController: UIViewController,
                                     StoryboardInstantiableProtocol,
                                     AlertableProtocol {
    
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Private Method

private extension TVRelatedViewController {
    
    func fetchTVDetail(id: Int) {
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

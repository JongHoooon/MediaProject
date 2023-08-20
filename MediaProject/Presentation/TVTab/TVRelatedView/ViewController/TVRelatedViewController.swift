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
    var similarVideos: [Video] = []
    var relatedVideoInfos: [RelatedVideoInfo] = []
    
    @IBOutlet var relatedTableView: UITableView!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchRelatedInfos()
    }
}

extension TVRelatedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 {
            return similarVideos.count
        } else {
            return relatedVideoInfos.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SimilarTableViewCell.identifier,
                for: indexPath
            ) as? SimilarTableViewCell else {
                return UITableViewCell()
            }
            
            let row = similarVideos[indexPath.row]
            cell.configureCell(row: row)
            
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RelatedTableViewCell.identifier,
                for: indexPath
            ) as? RelatedTableViewCell else {
                return UITableViewCell()
            }
            
            let row = relatedVideoInfos[indexPath.row]
            cell.configureCell(row: row)
            
            return cell
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        if section == 0 {
            return "비슷한 TV Series"
        } else {
            return "연관 비디오"
        }
    }
}

extension TVRelatedViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension TVRelatedViewController: UIApplicationDelegate {
    func configureTableView() {
        relatedTableView.dataSource = self
        relatedTableView.delegate = self
        
        let similarNib = UINib(
            nibName: SimilarTableViewCell.identifier,
            bundle: nil
        )
        relatedTableView.register(similarNib, forCellReuseIdentifier: SimilarTableViewCell.identifier)
        let relatedNib = UINib(
            nibName: RelatedTableViewCell.identifier,
            bundle: nil
        )
        relatedTableView.register(
            relatedNib,
            forCellReuseIdentifier: RelatedTableViewCell.identifier
        )
    }
}



// MARK: - Private Method

private extension TVRelatedViewController {
    
    
    
    func fetchRelatedInfos() {
       
       let group = DispatchGroup()
        
        group.enter()
        VideoAPI.fetchTVRelated(id: id).request
            .validate()
            .responseDecodable(
                of: RelatedVideoResponseDTO.self,
                completionHandler: { [weak self] response in
                    
                    switch response.result {
                    case let .success(value):
                        let relatedInfos = value.toRelatedVideoInfos()
                        self?.relatedVideoInfos = relatedInfos
                    case let .failure(error):
                        self?.presentAFError(error: error)
                    }

                    group.leave()
                }
            )
        
        group.enter()
        VideoAPI.fetchTVSimilar(id: id).request
            .validate()
            .responseDecodable(
                of: TVSimilarResponseDTO.self,
                completionHandler: { [weak self] response in
                    
                    switch response.result {
                    case let .success(value):
                        let similarVideos = value.toVideos()
                        self?.similarVideos = similarVideos
                    case let .failure(error):
                        self?.presentAFError(error: error)
                    }
                    
                    group.leave()
                }
            )
        
        group.notify(
            queue: .main,
            execute: { [weak self] in
                self?.relatedTableView.reloadData()
            }
        )
    }
}

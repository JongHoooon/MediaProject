//
//  VideoAPI.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation
import Alamofire

enum VideoAPI: APIableProtocol {
    case fetchTrendingVideo(type: VideoType)
    case fetchImage(url: String)
    case fetchCredits(id: Int)
    case fetchTVDetails(id: Int)
    case fetchTVSeason(id: Int, seasonNumber: Int)
    case fetchTVEpisode(id: Int, seasonNumber: Int, episodeNumber: Int)
    case fetchTVSimilar(id: Int)
    case fetchTVVideo(id: Int)
    
    var url: String {
        let baseURL = Endpoint.baseURL
        
        switch self {
        case let .fetchTrendingVideo(type):
            return baseURL+"/trending/\(type)/week"
        case let .fetchImage(url):
            return "https://image.tmdb.org/t/p/w500/"+url
        case let .fetchCredits(id):
            return baseURL+"/movie/\(id)/credits"
        case let .fetchTVDetails(id):
            return baseURL+"/tv/\(id)"
        case let .fetchTVSeason(id, seasonNumber):
            return baseURL+"/tv/\(id)/season/\(seasonNumber)"
        case let .fetchTVEpisode(id, seasonNumber, episodeNumber):
            return baseURL+"/tv/\(id)/season/\(seasonNumber)/episode/\(episodeNumber)"
        case let .fetchTVSimilar(id):
            return baseURL+"/tv/\(id)/similar"
        case .fetchTVVideo(id: let id):
            return baseURL+"/tv/\(id)/Videos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:                        return .get
        }
    }
     
    var parameters: [String: Any]? {
        switch self {
        default:                        return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchTrendingVideo,
             .fetchCredits,
             .fetchTVDetails,
             .fetchTVSeason,
             .fetchTVEpisode,
             .fetchTVSimilar,
             .fetchTVVideo:
            
            return [Header.accept.header, Header.authorization.header]
        case .fetchImage:
            
            return nil
        }
    }

    var request: DataRequest {
        return AF.request(
            self.url,
            method: self.method,
            parameters: self.parameters,
            headers: self.headers
        )
    }
}

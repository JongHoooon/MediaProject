//
//  Endpoint.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation

enum Endpoint {
    private static var baseURL: String {
        "https://api.themoviedb.org/3"
    }
    
    enum url {
        case fetchVideos(type: VideoType)
        case fetchImage(url: String)
        case fetchCredits(id: Int)
        
        var string: String {
            switch self {
            case let .fetchVideos(type):
                return baseURL+"/trending/\(type)/week"
            case let .fetchImage(url):
                return "https://image.tmdb.org/t/p/w500/"+url
            case let .fetchCredits(id):
                return baseURL+"/movie/\(id)/credits"
            }
        }
    }
}

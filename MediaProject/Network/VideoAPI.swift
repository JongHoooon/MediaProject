//
//  VideoAPI.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation
import Alamofire

enum VideoAPI: APIableProtocol {
    case fetchVideoList(type: VideoType)
    case fetchImage(url: String)
    case fetchCredits(id: Int)
    
    var url: String {
        switch self {
        case let .fetchVideoList(type):
            return Endpoint.url.fetchVideos(type: type).string
        case let .fetchImage(url):
            return Endpoint.url.fetchImage(url: url).string
        case let .fetchCredits(id):
            return Endpoint.url.fetchCredits(id: id).string
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchVideoList:           return .get
        case .fetchImage:               return .get
        case .fetchCredits:             return .get
        }
    }
     
    var parameters: [String: Any]? {
        switch self {
        case .fetchVideoList:           return nil
        case .fetchImage:               return nil
        case .fetchCredits:             return nil
        }
    }
    
    var headers: HTTPHeaders? {
        var headers: HTTPHeaders = [Header.accept.header]
        switch self {
        case .fetchVideoList, .fetchCredits:
            headers.add(Header.authorization.header)
            
            return headers
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

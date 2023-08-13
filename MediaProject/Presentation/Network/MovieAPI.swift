//
//  MovieAPI.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation
import Alamofire

enum MovieAPI {
    case fetchMovieList
    case fetchImage(url: String)
    case fetchCredits(id: Int)
    
    private var url: String {
        switch self {
        case .fetchMovieList:           return Endpoint.url.fetchMovies.string
        case let .fetchImage(url):      return Endpoint.url.fetchImage(url: url).string
        case let .fetchCredits(id):     return Endpoint.url.fetchCredits(id: id).string
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .fetchMovieList:           return .get
        case .fetchImage:               return .get
        case .fetchCredits:             return .get
        }
    }
    
    private var headers: HTTPHeaders? {
        var headers: HTTPHeaders = ["accept": "application/json"]
        switch self {
        case .fetchMovieList, .fetchCredits:
            headers["Authorization"] = "Bearer \(APIKey.authorization)"
            return headers
        case .fetchImage:
            return nil
        }
    }
    
    private var parameters: [String: Any]? {
        switch self {
        case .fetchMovieList:           return nil
        case .fetchImage:               return nil
        case .fetchCredits:             return nil
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

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
    
    private var url: String {
        switch self {
        case .fetchMovieList:           return Endpoint.movies
        case let .fetchImage(url):      return Endpoint.fetchImage+url
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .fetchMovieList:           return .get
        case .fetchImage:               return .get
        }
    }
    
    private var headers: HTTPHeaders? {
        var headers: HTTPHeaders = ["accept": "application/json"]
        switch self {
        case .fetchMovieList:
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

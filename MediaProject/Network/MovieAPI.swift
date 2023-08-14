//
//  MovieAPI.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation
import Alamofire

protocol MovieAPIableProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var request: DataRequest { get }
}

enum MovieAPI: MovieAPIableProtocol {
    case fetchMovieList
    case fetchImage(url: String)
    case fetchCredits(id: Int)
    
    var url: String {
        switch self {
        case .fetchMovieList:           return Endpoint.url.fetchMovies.string
        case let .fetchImage(url):      return Endpoint.url.fetchImage(url: url).string
        case let .fetchCredits(id):     return Endpoint.url.fetchCredits(id: id).string
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchMovieList:           return .get
        case .fetchImage:               return .get
        case .fetchCredits:             return .get
        }
    }
     
    var parameters: [String: Any]? {
        switch self {
        case .fetchMovieList:           return nil
        case .fetchImage:               return nil
        case .fetchCredits:             return nil
        }
    }
    
    var headers: HTTPHeaders? {
        var headers: HTTPHeaders = ["accept": "application/json"]
        switch self {
        case .fetchMovieList, .fetchCredits:
            headers["Authorization"] = "Bearer \(APIKey.authorization)"
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
    
    var dto: Decodable.Type {
        switch self {
        case .fetchMovieList:       return MovieListResponseDTO.self
        default:                    return MovieListResponseDTO.self
        }
    }
}

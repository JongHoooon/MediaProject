//
//  MovieManager.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Alamofire

final class MovieManager: MovieManagerableProtocol {
    
    static var shared = MovieManager()
    private init() {}
    
    func callRequest<T: Decodable>(
        movieAPI: MovieAPI,
        completionHandler: @escaping (T) -> Void,
        errrorHandler: @escaping (AFError) -> Void
    ) {
        movieAPI.request
            .responseDecodable(
                of: T.self,
                completionHandler: { response in
                    switch response.result {
                    case let .success(value):
                        completionHandler(value)
                    case let .failure(error):
                        errrorHandler(error)
                    }
                }
            )
    }
}

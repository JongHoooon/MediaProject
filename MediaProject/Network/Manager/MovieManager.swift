//
//  MovieManager.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Alamofire

final class MovieManager: ManagerableProtocol {
    
    static var shared = MovieManager()
    private init() {}
    
    func callRequest<T: Decodable>(
        movieAPI: VideoAPI,
        completionHandler: @escaping (Result<T, AFError>) -> Void
    ) {
        movieAPI.request
            .responseDecodable(
                of: T.self,
                completionHandler: { response in
                    switch response.result {
                    case let .success(value):
                        completionHandler(.success(value))
                    case let .failure(error):
                        completionHandler(.failure(error))
                    }
                }
            )
    }
}

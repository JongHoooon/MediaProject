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
        of: T.Type,
        movieAPI: VideoAPI
    ) async throws -> T {
        
        let result = await movieAPI
            .request
            .serializingDecodable(T.self)
            .result
        
        switch result {
        case let .success(value):
            return value
        case let .failure(error):
            throw(error)
        }
    }
}

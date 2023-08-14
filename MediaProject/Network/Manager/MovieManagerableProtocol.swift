//
//  MovieManagerableProtocol.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//S

import Alamofire

protocol MovieManagerableProtocol: ManagerableProtocol {
    func callRequest<T: Decodable>(
        movieAPI: MovieAPI,
        completionHandler: @escaping (T) -> Void,
        errrorHandler: @escaping (AFError) -> Void
    )
}

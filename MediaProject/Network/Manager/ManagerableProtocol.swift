//
//  ManagerableProtocol.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation
import Alamofire

protocol ManagerableProtocol {
    associatedtype APIable: APIableProtocol
    
    static var shared: Self { get }
    func callRequest<T: Decodable>(
        movieAPI: APIable,
        completionHandler: @escaping (T) -> Void,
        errrorHandler: @escaping (AFError) -> Void
    )
}

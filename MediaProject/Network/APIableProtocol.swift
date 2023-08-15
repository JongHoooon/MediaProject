//
//  APIableProtocol.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/15.
//

import Alamofire

protocol APIableProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var request: DataRequest { get }
}

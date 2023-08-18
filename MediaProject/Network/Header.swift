//
//  Header.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/15.
//

import Alamofire

enum Header {
    case accept
    case authorization

    var header: HTTPHeader {
        switch self {
        case .accept:
            return HTTPHeader(name: "accept", value: "application/json")
        case .authorization:
            return HTTPHeader(name: "Authorization", value: "Bearer \(APIKey.authorization)")
        }
    }
}

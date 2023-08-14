//
//  ManagerableProtocol.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation
import Alamofire

protocol ManagerableProtocol {
    static var shared: Self { get }
}

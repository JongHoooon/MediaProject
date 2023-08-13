//
//  ReusableProtocol.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import Foundation
import UIKit

protocol ReusableProtocol {}

extension ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {}
extension UIViewController: ReusableProtocol {}

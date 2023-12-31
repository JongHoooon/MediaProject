//
//  AlertableProtocol.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit
import Alamofire

protocol AlertableProtocol {}

extension AlertableProtocol where Self: UIViewController {
    func presentSimpleAlert(
        title: String? = nil,
        message: String
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(
            title: "확인",
            style: .default
        )
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true)
    }
    
    func presentAFError(error: Error) {
        guard let afError = error as? AFError else {
            presentSimpleAlert(message: error.localizedDescription)
            return
        }
        
        if let description = afError.errorDescription {
            presentSimpleAlert(message: description)
        } else {
            presentSimpleAlert(message: String(describing: afError))
        }
    }
}

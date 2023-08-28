//
//  BaseViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
}

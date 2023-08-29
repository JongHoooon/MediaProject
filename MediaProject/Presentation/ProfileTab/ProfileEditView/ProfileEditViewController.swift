//
//  ProfileEditViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

protocol ChangeNickNameDelegate: AnyObject {
    func changeNickname(newNickname: String)
}

final class ProfileEditViewController: BaseViewController {
    
    // MARK: - Properties
    private let mainView = ProfileEditView()
    private let editCategory: ProfileEditCategory
    
    weak var delegate: ChangeNickNameDelegate?
    var changeGender: ((String) -> Void)?
    #warning("클로저는 순환참조 어떻게??")
        
    // MARK: - Init
    init(editCategory: ProfileEditCategory) {
        self.editCategory = editCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        mainView.titleLabel.text = editCategory.title
        configureNavigationBar()
    }
}

private extension ProfileEditViewController {
    
    func configureNavigationBar()  {
        navigationItem.title = editCategory.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(completeClicked)
        )
    }
    
    @objc
    func completeClicked() {
        
        guard let inputText = mainView.textField.text else { return }
        
        switch editCategory {
        case .name:
            NotificationCenter.default.post(
                name: .changeName,
                object: nil,
                userInfo: ["name": inputText]
            )
        case .nickname:
            delegate?.changeNickname(newNickname: inputText)
        case .gender:
            changeGender?(inputText)
        default: break
        }
        
        navigationController?.popViewController(animated: true)
    }
}

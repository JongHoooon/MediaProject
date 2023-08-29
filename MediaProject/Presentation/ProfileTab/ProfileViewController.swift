//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    private let mainView = ProfileView()
    private let profileEditCategories = ProfileEditCategory.allCases
    private lazy var placeholders: [String] = self.profileEditCategories.map {
        $0.placeholder
    }
    private var needTableViewReload: (row: Int, need: Bool)?
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if needTableViewReload?.need == true {
            mainView.editTableView.reloadRows(
                at: [IndexPath(row: needTableViewReload?.row ?? 0, section: 0)],
                with: .none
            )
            needTableViewReload = nil
        }
    }
    
    override func configureView() {
        super.configureView()
        configureNavigationBar()
        configureTableView()
    }
}

// MARK: - Table View
extension ProfileViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return profileEditCategories.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.identifier,
            for: indexPath
        ) as? ProfileTableViewCell else { return UITableViewCell() }
        
        let row = profileEditCategories[indexPath.row]
        let placeholder = placeholders[indexPath.row]
        cell.configureCell(category: row, placeholder: placeholder)

        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        mainView.editTableView.deselectRow(at: indexPath, animated: true)
        
        guard let editCategory = ProfileEditCategory(rawValue: indexPath.row) else { return }
        let vc = ProfileEditViewController(editCategory: editCategory)

        switch editCategory {
        case .name:
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(changeName),
                name: .changeName,
                object: nil
            )
        case .nickname:
            vc.delegate = self
        case .gender:
            vc.changeGender = { [weak self] text in
                let row = ProfileEditCategory.gender.rawValue
                self?.placeholders[row] = text
                self?.needTableViewReload = (row, true)
                
            }
        default:
            return
        }
    
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: ChangeNickNameDelegate {
    func changeNickname(newNickname: String) {
        let row = ProfileEditCategory.nickname.rawValue
        placeholders[row] = newNickname
        needTableViewReload = (row, true)
    }
}

// MARK: - Private
private extension ProfileViewController {
    
    func configureNavigationBar() {
        navigationItem.title = "프로필 편집"
        navigationItem.backButtonTitle = ""
    }
    
    func configureTableView() {
        mainView.editTableView.dataSource = self
        mainView.editTableView.delegate = self
    }
    
    @objc
    func changeName(notification: NSNotification) {
        guard let name = notification.userInfo?["name"] as? String else { return }
        let row = ProfileEditCategory.name.rawValue
        placeholders[row] = name
        needTableViewReload = (row, true)
    }
}


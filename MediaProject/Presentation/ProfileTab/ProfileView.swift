//
//  ProfileView.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class ProfileView: BaseView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .systemGray6
        return imageView
    }()
    let imageEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진 또는 이미지 수정", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        return button
    }()
    let editTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            ProfileTableViewCell.self,
            forCellReuseIdentifier: ProfileTableViewCell.identifier
        )
        tableView.rowHeight = 32.0
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func configureView() {
        [
            profileImageView,
            imageEditButton,
            editTableView
        ].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(100.0)
        }
        profileImageView.layer.cornerRadius = 100.0 / 2.0
        
        imageEditButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        editTableView.snp.makeConstraints {
            $0.top.equalTo(imageEditButton.snp.bottom).offset(16.0)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

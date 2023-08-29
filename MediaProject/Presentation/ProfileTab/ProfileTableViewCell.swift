//
//  ProfileTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class ProfileTableViewCell: BaseTableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 이름"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        return label
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "dfdfdfdfefefe"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()
    
    override func configureView() {
        [
            titleLabel,
            infoLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    func configureCell(category: ProfileEditCategory, placeholder: String) {
        titleLabel.text = category.title
        infoLabel.text = placeholder
    }
    
    override func setupContstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8.0)
            $0.width.equalTo(80.0)
            $0.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(8.0)
            $0.centerY.equalToSuperview()
        }
    }
}

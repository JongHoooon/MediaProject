//
//  ProfileEditView.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

final class ProfileEditView: BaseView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 13.0)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .label
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func configureView() {
        [
            titleLabel,
            textField
        ].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16.0)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.horizontalEdges.equalTo(titleLabel)
            $0.height.equalTo(36.0)
        }
    }
}

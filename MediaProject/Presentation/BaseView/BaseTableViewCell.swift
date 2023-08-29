//
//  BaseTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setupContstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        setupContstraints()
    }
    
    func configureView() {}
    func setupContstraints() {}
}

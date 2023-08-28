//
//  BaseTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() {}
}

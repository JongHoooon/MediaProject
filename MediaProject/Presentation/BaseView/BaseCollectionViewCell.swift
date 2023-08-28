//
//  BaseCollectionViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // class로 register했을 때 실행됨
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // nib으로 register했을 때 실행됨
        configureView()
        setConstraints()
    }
    
    func configureView() {}
    func setConstraints() {}
}

//
//  PaddingLabel.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(
        top: 4.0,
        left: 4.0,
        bottom: 4.0,
        right: 4.0
    )

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}

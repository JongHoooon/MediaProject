//
//  MPImage.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

enum MPImage {
    enum PlaceholderImage {
        static let movie = UIImage(systemName: "popcorn.fill")?
            .withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        static let person = UIImage(systemName: "person.fill")?
            .withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    }
    
    enum SystemName {
        static let chevronDown = "chevron.down"
        static let chevronUp = "chevron.up"
    }
}

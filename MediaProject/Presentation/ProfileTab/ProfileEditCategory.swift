//
//  ProfileEditCategory.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/29.
//

import Foundation

enum ProfileEditCategory: Int, CaseIterable {
    case name
    case nickname
    case gender
    case introduce
    case link
    
    var title: String {
        switch self {
        case .name:             return "이름"
        case .nickname:         return "사용자 이름"
        case .gender:           return "성별 대명사"
        case .introduce:        return "소개"
        case .link:             return "링크 추가"
        }
    }
    
    var placeholder: String {
        switch self {
        case .name:             return "이름을 입력해주세요."
        case .nickname:         return "사용자 이름을 입력해주세요."
        case .gender:           return "성별 대명사를 입력해주세요."
        case .introduce:        return "소개"
        case .link:             return "링크"
        }
    }
}

//
//  StoryboardInstantiableProtocol.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

protocol StoryboardInstantiableProtocol: NSObject {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

extension StoryboardInstantiableProtocol where Self: UIViewController & ReusableProtocol {
    static var defaultFileName: String {
        return String(NSStringFromClass(Self.self).split(separator: ".").last!)
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Storyboard로 ViewController 인스턴스화를 실패했습니다.")
        }
        
        return vc
    }
}

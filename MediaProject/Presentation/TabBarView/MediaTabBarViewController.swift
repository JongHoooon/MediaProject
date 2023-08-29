//
//  MediaTabBarViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/29.
//

import UIKit

enum TabBarType: CaseIterable {
    case movie
    case tv
    case profile
    
    var title: String {
        switch self {
        case .movie:        return "Movie"
        case .tv:           return "TV"
        case .profile:      return "Profile"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .movie:        return UIImage(systemName: "video.fill")
        case .tv:           return UIImage(systemName: "tv.inset.filled")
        case .profile:      return UIImage(systemName: "person.fill")
        }
    }
}

final class MediaTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    func configureTabBar() {
        let movieListViewController =  MovieListViewController.instantiateViewController()
        let tvListViewController = TVListViewController.instantiateViewController()
        let profileViewController = ProfileViewController()
        
        let tabBarViewControllers = [
            movieListViewController, tvListViewController, profileViewController
        ]
        
        let vcs = zip(tabBarViewControllers, TabBarType.allCases)
            .map { vc, type in
                let nav = UINavigationController(rootViewController: vc)
                nav.tabBarItem = UITabBarItem(
                    title: type.title,
                    image: type.icon,
                    selectedImage: type.icon
                )
                return nav
            }
        
        setViewControllers(vcs, animated: true)
    }
}

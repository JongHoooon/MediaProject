//
//  IntroPageViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/25.
//

import UIKit

final class IntroPageViewController: UIPageViewController {
    
    // MARK: - Properties
    let viewControllerList: [UIViewController] = [
        PageViewController(posterImage: UIImage(named: "아바타")),
        PageViewController(posterImage: UIImage(named: "알라딘")),
        PageViewController(posterImage: UIImage(named: "암살"))
    ]
    
    // MARK: - UI
    private let dismissBarButton = UIBarButtonItem(
        image: UIImage(systemName: "xmark"),
        style: .plain,
        target: nil,
        action: nil
    )
    
    // MARK: - Init
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureNavigationBar()
        addAction()
        
        delegate = self
        dataSource = self
        view.backgroundColor = .black
        
        guard let first = viewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

extension IntroPageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : viewControllerList[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        return nextIndex >= viewControllerList.count ? nil : viewControllerList[nextIndex]
    }
}

extension IntroPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
        
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
              let index = viewControllerList.firstIndex(of: first)
        else {
            return 0
        }
        return index
    }
}

private extension IntroPageViewController {
    
    func addAction() {
        dismissBarButton.target = self
        dismissBarButton.action = #selector(dissmissView)
    }
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = dismissBarButton
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc
    func dissmissView() {
        dismiss(animated: true)
    }
}

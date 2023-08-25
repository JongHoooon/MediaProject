//
//  PageViewController.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/25.
//

import UIKit

import SnapKit

final class PageViewController: UIViewController {
    
    // MARK: - Properties
    let posterImage: UIImage?
    
    // MARK: - UI
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Init
    init(posterImage: UIImage?) {
        self.posterImage = posterImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configurePosterImage()
    }
}

// MARK: - Layout
private extension PageViewController {
    
    func configureLayout() {
        view.addSubview(posterImageView)
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Private
private extension PageViewController {
    
    func configurePosterImage() {
        self.posterImageView.image = posterImage
    }
}

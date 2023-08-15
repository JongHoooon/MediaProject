//
//  InfoTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var viewMoreButtonTapped: ((Bool) -> Void)?
    
    @IBOutlet private var viewMoreButton: UIButton!
    var overview: String? {
        didSet {
            overViewLabel.text = overview
        }
    }
    var isViewMoreButtonTapped = false {
        didSet {
            switch isViewMoreButtonTapped {
            case true:
                overViewLabel.numberOfLines = 0
                viewMoreButton.setImage(
                    UIImage(systemName: MPImage.System.chevronUp),
                    for: .normal
                )
                
            case false:
                overViewLabel.numberOfLines = 2
                viewMoreButton.setImage(
                    UIImage(systemName: MPImage.System.chevronDown),
                    for: .normal
                )
            }
            
            if let viewMoreButtonTapped = viewMoreButtonTapped {
                viewMoreButtonTapped(isViewMoreButtonTapped)
            }
        }
    }
    
    // MARK: - UI
    
    @IBOutlet private var separator1: UIView!
    @IBOutlet private var separator2: UIView!
    @IBOutlet private var separator3: UIView!
    @IBOutlet private var overViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [
            separator1,
            separator2,
            separator3
        ].forEach { $0?.backgroundColor = .separator }
        selectionStyle = .none
    }

    @IBAction func viewMoreButtonTapped(_ sender: UIButton) {
            isViewMoreButtonTapped.toggle()
       }
}
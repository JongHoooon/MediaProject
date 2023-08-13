//
//  DetailTableViewCell.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
    }
    
    func configureCell(with row: Cast) {
        MovieAPI.fetchImage(url: row.profilePath ?? "").request
            .responseData(completionHandler: { [weak self] response in
                switch response.result {
                case let .success(value):
                    self?.profileImageView.image = UIImage(data: value)
                case let .failure(error):
                    print(error)
                }
            })
        nameLabel.text = row.name
        infoLabel.text = row.character
    }
}

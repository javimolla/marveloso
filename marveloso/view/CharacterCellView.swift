//
//  CharacterCellView.swift
//  marveloso
//
//  Created by liver6 on 25/02/2021.
//

import UIKit
import SDWebImage

class CharacterCellView: UITableViewCell {
    static let identifier = "characterCellView"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func configure(with character: CharacterSimple?) {
        if let character = character {
            self.nameLabel.text = character.name
            setImage(character.thumbnail)
        } else {
            nameLabel.isHidden = true
            thumbnailView.isHidden = true
            spinner.isHidden = false
            spinner.startAnimating()
        }
    }
    
    private func setNameProps() {
        let color = UIColor(red: 0.85, green: 0.02, blue: 0.0, alpha: 1.0)
        nameLabel.textColor = color
        let background = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        nameLabel.layer.backgroundColor = background.cgColor;
        nameLabel.layer.borderColor = background.cgColor;
        nameLabel.layer.borderWidth = 1.0;
        nameLabel.layer.cornerRadius = 3;
        nameLabel.layer.masksToBounds = true;
    }
    
    private func setImage(_ thumbnailUrl: String) {
        thumbnailView.sd_setImage(with: URL(string: thumbnailUrl), completed: { ( image: UIImage?, error: Error?, SDImageCacheType, _: URL?) in
            self.nameLabel.isHidden = false
            self.setNameProps()
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            if (error == nil) {
                self.thumbnailView.isHidden = false
                self.thumbnailView.image = image
            }
        })
    }
}

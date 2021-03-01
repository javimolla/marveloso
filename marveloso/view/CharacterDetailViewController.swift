//
//  CharacterDetailViewController.swift
//  marveloso
//
//  Created by javimolla on 28/02/2021.
//

import UIKit
import SDWebImage

protocol CharacterDetailView: class {
    func onCharacterRetrieved(_ character: CharacterDetail)
    func onError(_ error: String)
}

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var presenter: CharacterDetailViewPresenter!
    var character: CharacterDetail? = nil
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpinner()
        setupPresenter()
    }
    
    private func setupSpinner() {
        self.view.bringSubviewToFront(spinner);
    }

    private func setupPresenter() {
        if (presenter == nil) {
            presenter = CharacterDetailPresenter(view: self)
        }
        loadCharacter()
    }
    
    private func loadCharacter() {
        showAnimation()
        presenter.loadCharacter(id)
    }
    
    private func showAnimation() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    private func hideAnimation() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    private func showError(_ error: String) {
        let uialert = UIAlertController(title: "Error obteniendo el personaje",
                                        message: error,
                                        preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        uialert.addAction(UIAlertAction(title: "Reintentar", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.loadCharacter()
        }))
        self.present(uialert, animated: true, completion: nil)
    }
    
    private func setImage(_ imageUrl: String) {
        imageView.sd_setImage(with: URL(string: imageUrl), completed: { ( image: UIImage?, error: Error?, SDImageCacheType, _: URL?) in
            if (error != nil) {
                self.imageView.image = image
            }
        })
    }
}

extension CharacterDetailViewController: CharacterDetailView {
    func onCharacterRetrieved(_ character: CharacterDetail) {
        self.character = character
        self.nameLabel.text = character.name
        self.descriptionLabel.text = character.description
        self.setImage(character.image)
        hideAnimation()
    }
    
    func onError(_ error: String) {
        self.showError(error)
        self.hideAnimation()
    }
}

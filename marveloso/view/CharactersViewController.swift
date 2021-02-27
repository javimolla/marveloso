//
//  CharactersViewController.swift
//  marveloso
//
//  Created by javimolla on 13/02/2021.
//

import UIKit
import SwiftyGif

class CharactersViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    let logoAnimationView = LogoAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        setupSpinner()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func setupAnimation() {
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
    }
    
    private func setupSpinner() {
        self.view.bringSubviewToFront(spinner);
    }
    
    private func showAnimation() {
        logoAnimationView.isHidden = false
        logoAnimationView.logoGifImageView.startAnimatingGif()
        spinner.isHidden = false
        spinner.startAnimating()
    }

    private func hideAnimation() {
        logoAnimationView.isHidden = true
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}

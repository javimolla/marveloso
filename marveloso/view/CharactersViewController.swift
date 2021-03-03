//
//  CharactersViewController.swift
//  marveloso
//
//  Created by javimolla on 13/02/2021.
//

import UIKit
import SwiftyGif

protocol CharactersView: class {
    func onCharactersRetrieved(_ newCharactersIndex: Int)
    func onError(_ error: String)
}

class CharactersViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyList: UIImageView!
    let logoAnimationView = LogoAnimationView()
    var presenter: CharactersViewPresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimation()
        setupSpinner()
        setupCharactersList()
        setupEmptyList()
        setupPresenter()
    }
    
    private func setupAnimation() {
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        showAnimation()
    }
    
    private func setupSpinner() {
        self.view.bringSubviewToFront(spinner);
    }
    
    private func setupPresenter() {
        if (presenter == nil) {
            presenter = CharactersPresenter(view: self)
            presenter.loadCharacters()
        }
    }
    
    private func setupCharactersList() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
    
    private func setupEmptyList() {
        hideEmptyList()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(emptyListTapped(tapGestureRecognizer:)))
        emptyList.isUserInteractionEnabled = true
        emptyList.addGestureRecognizer(tapGestureRecognizer)
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
    
    private func showCharactersList() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func hideCharactersList() {
        tableView.isHidden = true
    }
    
    private func showEmptyList() {
        emptyList.isHidden = false
    }
    
    private func hideEmptyList() {
        emptyList.isHidden = true
    }
    
    private func showError(_ error: String) {
        let uialert = UIAlertController(title: "Error obteniendo los personajes",
                                        message: error,
                                        preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            self.hideAnimation()
            self.hideCharactersList()
            self.showEmptyList()
        }))
        uialert.addAction(UIAlertAction(title: "Reintentar", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.showAnimation()
            self.presenter.loadCharacters()
        }))
        self.present(uialert, animated: true, completion: nil)
    }
    
    private func calculateIndexPathsToReload(from newCharactersIndex: Int) -> [IndexPath] {
        let startIndex = presenter.getCharactersCount() - newCharactersIndex
        let endIndex = startIndex + newCharactersIndex
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> CharacterDetailViewController? {
        let controller = CharacterDetailViewController(coder: coder)
        controller?.id = presenter.getCharacter(index: tableView.indexPathForSelectedRow?.row ?? 0).id;
        return controller
    }

    @objc func emptyListTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        hideEmptyList()
        showAnimation()
        presenter.loadCharacters()
    }
}

extension CharactersViewController: CharactersView {
    func onCharactersRetrieved(_ newCharactersIndex: Int) {
        DispatchQueue.main.async {
            if (self.presenter.getCharactersCount() != newCharactersIndex) {
                let indexPathsToReload = self.visibleIndexPathsToReload(
                    intersecting: self.calculateIndexPathsToReload(from: newCharactersIndex))
                self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
            } else {
                self.hideAnimation()
                self.showCharactersList()
            }
        }
    }
    
    func onError(_ error: String) {
        DispatchQueue.main.async {
            self.showError(error)
            self.hideAnimation()
        }
    }
}

extension CharactersViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if (indexPaths.contains(where: isLoadingCell)) {
            presenter.loadCharacters()
        }
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueDetail", sender: self)
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter != nil ? presenter.getCharactersTotal() : 0
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCellView.identifier,
                   for: indexPath) as! CharacterCellView
        if (isLoadingCell(for: indexPath)) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: presenter.getCharacter(index: indexPath.row))
        }
        
        return cell
    }
}

private extension CharactersViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= presenter.getCharactersCount()
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

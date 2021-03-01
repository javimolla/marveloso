//
//  CharactersViewController.swift
//  marveloso
//
//  Created by javimolla on 13/02/2021.
//

import UIKit
import SwiftyGif

protocol CharactersView: class {
    func onCharactersRetrieved(_ characters: [CharacterSimple], _ total: Int)
    func onError(_ error: MarvelService.MarvelServiceError)
}

class CharactersViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyList: UIImageView!
    let logoAnimationView = LogoAnimationView()
    var presenter: CharactersViewPresenter!
    var characters: [CharacterSimple] = []
    var totalCharacters: Int = 0
    var isFetchInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        setupSpinner()
        setupPresenter()
        setupCharactersList()
        setupEmptyList()
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
        }
        loadCharacters()
    }
    
    private func setupCharactersList() {
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
    
    private func loadCharacters() {
        isFetchInProgress = true
        presenter.loadCharacters(characters.count)
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
    
    private func showError(_ error: MarvelService.MarvelServiceError) {
        let uialert = UIAlertController(title: "Error obteniendo los personajes",
                                        message: error.localizedDescription,
                                        preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            self.hideAnimation()
            self.hideCharactersList()
            self.showEmptyList()
        }))
        uialert.addAction(UIAlertAction(title: "Reintentar", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            if (self.totalCharacters == 0) {
                self.showAnimation()
            }
            self.loadCharacters()
        }))
        self.present(uialert, animated: true, completion: nil)
    }
    
    private func calculateIndexPathsToReload(from newCharacters: [CharacterSimple]) -> [IndexPath] {
        let startIndex = characters.count - newCharacters.count
        let endIndex = startIndex + newCharacters.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    @objc func emptyListTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.hideEmptyList()
        self.showAnimation()
        self.loadCharacters()
    }
}

extension CharactersViewController: CharactersView {
    func onCharactersRetrieved(_ characters: [CharacterSimple], _ totalCharacters: Int) {
        DispatchQueue.main.async {
            self.isFetchInProgress = false
            self.characters.append(contentsOf: characters)
            self.totalCharacters = totalCharacters
            if (self.characters.count != characters.count) {
                let indexPathsToReload = self.visibleIndexPathsToReload(
                    intersecting: self.calculateIndexPathsToReload(from: characters))
                self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
            } else {
                self.hideAnimation()
                self.showCharactersList()
            }
        }
    }
    
    func onError(_ error: MarvelService.MarvelServiceError) {
        DispatchQueue.main.async {
            self.isFetchInProgress = false
            self.showError(error)
            self.hideAnimation()
        }
    }
}

extension CharactersViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if (isFetchInProgress) {
            return
        }
        
        if (indexPaths.contains(where: isLoadingCell)) {
            loadCharacters()
        }
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCharacters
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCellView.identifier,
                   for: indexPath) as! CharacterCellView
        if (isLoadingCell(for: indexPath)) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: characters[indexPath.row])
        }
        
        return cell
    }
}

private extension CharactersViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= characters.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

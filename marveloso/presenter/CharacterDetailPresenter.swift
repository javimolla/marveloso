//
//  CharacterDetailPresenter.swift
//  marveloso
//
//  Created by javimolla on 28/02/2021.
//

import Foundation

protocol CharacterDetailViewPresenter: class {
    func loadCharacter(_ id: Int)
}

class CharacterDetailPresenter: CharacterDetailViewPresenter {
    weak var view: CharacterDetailView?
    
    let marvelService: MarvelService?
    
    required init(view: CharacterDetailView) {
        self.view = view
        self.marvelService = ServiceResolver.getMarvelService()
    }
    
    func loadCharacter(_ id: Int) {
        marvelService!.getCharacterDetail(id) { (character: CharacterDetail?,
                                                 error: String?) in
            if (error == nil) {
                self.view?.onCharacterRetrieved(character!)
            } else {
                self.view?.onError(error!)
            }
        }
    }
}

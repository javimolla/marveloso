//
//  CharacterDetailPresenter.swift
//  marveloso
//
//  Created by javimolla on 28/02/2021.
//

import Foundation

protocol CharacterDetailViewPresenter: class {
    func getCharacter() -> CharacterDetail
    func loadCharacter(_ id: Int)
}

class CharacterDetailPresenter: CharacterDetailViewPresenter {
    weak var view: CharacterDetailView?
    var character: CharacterDetail?
    var isFetchInProgress = false
    
    required init(view: CharacterDetailView) {
        self.view = view
    }
    
    func getCharacter() -> CharacterDetail {
        return character!
    }
    
    func loadCharacter(_ id: Int) {
        if (isFetchInProgress) {
            return
        }
        
        isFetchInProgress = true
        ServiceResolver.getMarvelService().getCharacterDetail(id) { (character: CharacterDetail?,
                                                                     error: String?) in
            if (error == nil) {
                self.character = character!
                self.view?.onCharacterRetrieved()
            } else {
                self.view?.onError(error!)
            }
            self.isFetchInProgress = false
        }
    }
}

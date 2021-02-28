//
//  CharactersPresenter.swift
//  marveloso
//
//  Created by javimolla on 25/02/2021.
//

import Foundation

protocol CharactersViewPresenter: class {
    func loadCharacters(_ first: Int)
}

class CharactersPresenter: CharactersViewPresenter {
    weak var view: CharactersView?
    
    let marvelService = MarvelService()
    
    required init(view: CharactersView) {
        self.view = view
    }
    
    func loadCharacters(_ first: Int) {
        self.marvelService.getCharactersSimple(first) { (characters: [CharacterSimple]?,
                                                         totalCharacters: Int?,
                                                         error: MarvelService.MarvelServiceError?) in
            if (error == nil) {
                self.view?.onCharactersRetrieved(characters!, totalCharacters!)
            } else {
                self.view?.onError(error!)
            }
        }
    }
}

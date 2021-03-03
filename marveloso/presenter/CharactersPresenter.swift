//
//  CharactersPresenter.swift
//  marveloso
//
//  Created by javimolla on 25/02/2021.
//

import Foundation

protocol CharactersViewPresenter: class {
    func getCharacter(index: Int) -> CharacterSimple
    func getCharactersCount() -> Int
    func getCharactersTotal() -> Int
    func loadCharacters()
}

class CharactersPresenter: CharactersViewPresenter {
    weak var view: CharactersView?
    var characters: [CharacterSimple] = []
    var totalCharacters: Int = 0
    var isFetchInProgress = false
    
    required init(view: CharactersView) {
        self.view = view
    }
    
    func getCharacter(index: Int) -> CharacterSimple {
        return characters[index]
    }
    
    func getCharactersCount() -> Int {
        return characters.count
    }
    
    func getCharactersTotal() -> Int {
        return totalCharacters
    }
    
    func loadCharacters() {
        if (isFetchInProgress) {
            return
        }
        
        isFetchInProgress = true
        ServiceResolver.getMarvelService().getCharactersSimple(characters.count) { (characters: [CharacterSimple]?,
                                                                                    totalCharacters: Int?,
                                                                                    error: String?) in
            if (error == nil) {
                self.characters.append(contentsOf: characters!)
                self.totalCharacters = totalCharacters!
                self.view?.onCharactersRetrieved(characters!.count)
            } else {
                self.view?.onError(error!)
            }
            self.isFetchInProgress = false
        }
    }
}

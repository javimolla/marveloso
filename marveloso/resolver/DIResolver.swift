//
//  DIResolver.swift
//  marveloso
//
//  Created by javimolla on 01/03/2021.
//

import Foundation

class DIResolver {
    static var marvelService: MarvelService?
    static var charactersPresenter: CharactersViewPresenter?
    
    static func getMarvelService() -> MarvelService {
        return DIResolver.marvelService ?? MarvelServiceImpl()
    }
    
    static func getCharactersPresenter(view: CharactersView) -> CharactersViewPresenter {
        return DIResolver.charactersPresenter ?? CharactersPresenter(view: view)
    }
}

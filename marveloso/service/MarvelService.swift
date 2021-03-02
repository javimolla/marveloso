//
//  MarvelService.swift
//  marveloso
//
//  Created by javimolla on 28/02/2021.
//

protocol MarvelService {
    func getCharactersSimple(_ offset: Int,
                             _ completion: @escaping ((_ characters: [CharacterSimple]?,
                                                       _ totalCharacters: Int?,
                                                       _ error: String?) -> Void))

    func getCharacterDetail(_ id: Int,
                            _ completion: @escaping ((_ character: CharacterDetail?,
                                                      _ error: String?) -> Void))
}

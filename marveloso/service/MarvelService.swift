//
//  MarvelService.swift
//  marveloso
//
//  Created by javimolla on 28/02/2021.
//

enum MarvelServiceError: Error {
    case apiDown
    case nothingFound
    case unexpected(_ localizedDescription: String?)
}

protocol MarvelService {
    func getCharactersSimple(_ offset: Int,
                             _ completion: @escaping ((_ characters: [CharacterSimple]?,
                                                       _ totalCharacters: Int?,
                                                       _ error: MarvelServiceError?) -> Void))

    func getCharacterDetail(_ id: Int,
                            _ completion: @escaping ((_ character: CharacterDetail?,
                                                      _ error: MarvelServiceError?) -> Void))
}

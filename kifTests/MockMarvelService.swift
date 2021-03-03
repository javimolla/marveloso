//
//  MockMarvelService.swift
//  kifTests
//
//  Created by javimolla on 03/03/2021.
//

@testable import marveloso

class MockMarvelService: MarvelService {
    func getCharactersSimple(_ offset: Int,
                             _ completion: @escaping ((_ characters: [CharacterSimple]?,
                                                       _ totalCharacters: Int?,
                                                       _ error: String?) -> Void)) {
        completion([CharacterSimple(id: 1, name: "name", thumbnail: "thumbnail")], 100, nil)
    }
    
    func getCharacterDetail(_ id: Int,
                            _ completion: @escaping ((_ character: CharacterDetail?,
                                                      _ error: String?) -> Void)) {
        completion(CharacterDetail(name: "name", description: "description", image: "image"), nil)
    }
}

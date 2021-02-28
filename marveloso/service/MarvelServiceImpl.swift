//
//  MarvelServiceImpl.swift
//  marveloso
//
//  Created by javimolla on 23/02/2021.
//

import Foundation

class MarvelServiceImpl: MarvelService {
    init() {
        SwaggerClientAPI.publicKey = environmentVariables.marvelPublicKey
        SwaggerClientAPI.privateKey = environmentVariables.marvelPrivateKey
    }
    
    func getCharactersSimple(_ offset: Int,
                             _ completion: @escaping ((_ characters: [CharacterSimple]?,
                                                       _ totalCharacters: Int?,
                                                       _ error: MarvelServiceError?) -> Void)) {
        PublicAPI.getCreatorCollection(limit: 100, offset: offset) { (data: CharacterDataWrapper?,
                                                                      error: Error?) in
            if (error != nil) {
                completion([], 0, self.getError(error!))
                return
            }
            
            completion(self.mapCharactersSimple(data!.data!), data!.data?.total, nil)
        }
    }
    
    func getCharacterDetail(_ id: Int,
                            _ completion: @escaping ((_ character: CharacterDetail?,
                                                      _ error: MarvelServiceError?) -> Void)) {
        PublicAPI.getCharacterIndividual(characterId: id) { (data: CharacterDataWrapper?,
                                                             error: Error?) in
            if (error != nil) {
                completion(nil, self.getError(error!))
                return
            }
            
            completion(self.mapCharactersDetail(data!.data!.results![0]), nil)
        }
    }
    
    private func getError(_ error: Error) -> MarvelServiceError {
        return MarvelServiceError.unexpected(error.localizedDescription)
    }
    
    private func mapCharactersSimple(_ data: CharacterDataContainer) -> [CharacterSimple] {
        return data.results?.map { (modelCharacter) -> CharacterSimple in
            return CharacterSimple(id: modelCharacter._id!,
                                   name: modelCharacter.name!,
                                   thumbnail: getImage(modelCharacter.thumbnail!, "landscape_large"))
        } ?? []
    }
    
    private func mapCharactersDetail(_ modelCharacter: ModelCharacter) -> CharacterDetail {
        return CharacterDetail(name: modelCharacter.name!,
                               description: modelCharacter._description!,
                               image: getImage(modelCharacter.thumbnail!, "detail"))
    }
    
    private func getImage(_ thumbnail: Image, _ size: String) -> String {
        return thumbnail.path! + "/" + size + "." + thumbnail._extension!
    }
}

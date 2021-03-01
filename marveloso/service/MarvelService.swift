//
//  MarvelService.swift
//  marveloso
//
//  Created by javimolla on 23/02/2021.
//

import Foundation

class MarvelService: NSObject {
    override init() {
        SwaggerClientAPI.publicKey = environmentVariables.marvelPublicKey
        SwaggerClientAPI.privateKey = environmentVariables.marvelPrivateKey
    }
    
    func getCharactersSimple(_ offset: Int,
                             _ completion: @escaping ((_ characters: [CharacterSimple]?,
                                                       _ totalCharacters: Int?,
                                                       _ error: String?) -> Void)) {
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
                                                      _ error: String?) -> Void)) {
        PublicAPI.getCharacterIndividual(characterId: id) { (data: CharacterDataWrapper?,
                                                             error: Error?) in
            if (error != nil) {
                completion(nil, self.getError(error!))
                return
            }
            
            completion(self.mapCharactersDetail(data!.data!.results![0]), nil)
        }
    }
    
    private func getError(_ error: Error) -> String {
        if let err = error as? ErrorResponse {
            switch (err) {
            case .error(409, _, let error):
                return error.localizedDescription
            case .error(500, _, let error):
                return error.localizedDescription
            default:
                return "Error inesperado al llamar a la API de Marvel"
            }
        } else {
            return "Error inesperado al llamar a la API de Marvel"
        }
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

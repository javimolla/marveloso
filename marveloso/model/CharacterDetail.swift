//
//  CharacterDetail.swift
//  marveloso
//
//  Created by javimolla on 23/02/2021.
//

import Foundation

struct CharacterDetail {
    public var name: String
    public var description: String
    public var image: String
    
    init(name: String, description: String, image: String) {
        self.name = name
        self.description = description
        self.image = image
    }
}

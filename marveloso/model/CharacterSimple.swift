//
//  CharacterSimple.swift
//  marveloso
//
//  Created by javimolla on 23/02/2021.
//

import Foundation

struct CharacterSimple {
    public var id: Int
    public var name: String
    public var thumbnail: String
    
    init(id: Int, name: String, thumbnail: String) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
    }
}

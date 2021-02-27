//
// CharacterSummary.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct CharacterSummary: Codable {

    /** The path to the individual character resource. */
    public var resourceURI: String?
    /** The full name of the character. */
    public var name: String?
    /** The role of the creator in the parent entity. */
    public var role: String?

    public init(resourceURI: String? = nil, name: String? = nil, role: String? = nil) {
        self.resourceURI = resourceURI
        self.name = name
        self.role = role
    }


}

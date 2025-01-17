//
// Url.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Url: Codable {

    /** A text identifier for the URL. */
    public var type: String?
    /** A full URL (including scheme, domain, and path). */
    public var url: String?

    public init(type: String? = nil, url: String? = nil) {
        self.type = type
        self.url = url
    }


}

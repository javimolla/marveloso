//
// ComicList.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ComicList: Codable {

    /** The number of total available issues in this list. Will always be greater than or equal to the \&quot;returned\&quot; value. */
    public var available: Int?
    /** The number of issues returned in this collection (up to 20). */
    public var returned: Int?
    /** The path to the full list of issues in this collection. */
    public var collectionURI: String?
    /** The list of returned issues in this collection. */
    public var items: [ComicSummary]?

    public init(available: Int? = nil, returned: Int? = nil, collectionURI: String? = nil, items: [ComicSummary]? = nil) {
        self.available = available
        self.returned = returned
        self.collectionURI = collectionURI
        self.items = items
    }


}

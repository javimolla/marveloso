//
// CreatorDataContainer.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct CreatorDataContainer: Codable {

    /** The requested offset (number of skipped results) of the call. */
    public var offset: Int?
    /** The requested result limit. */
    public var limit: Int?
    /** The total number of resources available given the current filter set. */
    public var total: Int?
    /** The total number of results returned by this call. */
    public var count: Int?
    /** The list of creators returned by the call. */
    public var results: [Creator]?

    public init(offset: Int? = nil, limit: Int? = nil, total: Int? = nil, count: Int? = nil, results: [Creator]? = nil) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }


}

//
// Comic.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Comic: Codable {

    /** The unique ID of the comic resource. */
    public var _id: Int?
    /** The ID of the digital comic representation of this comic. Will be 0 if the comic is not available digitally. */
    public var digitalId: Int?
    /** The canonical title of the comic. */
    public var title: String?
    /** The number of the issue in the series (will generally be 0 for collection formats). */
    public var issueNumber: Double?
    /** If the issue is a variant (e.g. an alternate cover, second printing, or director’s cut), a text description of the variant. */
    public var variantDescription: String?
    /** The preferred description of the comic. */
    public var _description: String?
    /** The date the resource was most recently modified. */
    public var modified: Date?
    /** The ISBN for the comic (generally only populated for collection formats). */
    public var isbn: String?
    /** The UPC barcode number for the comic (generally only populated for periodical formats). */
    public var upc: String?
    /** The Diamond code for the comic. */
    public var diamondCode: String?
    /** The EAN barcode for the comic. */
    public var ean: String?
    /** The ISSN barcode for the comic. */
    public var issn: String?
    /** The publication format of the comic e.g. comic, hardcover, trade paperback. */
    public var format: String?
    /** The number of story pages in the comic. */
    public var pageCount: Int?
    /** A set of descriptive text blurbs for the comic. */
    public var textObjects: [TextObject]?
    /** The canonical URL identifier for this resource. */
    public var resourceURI: String?
    /** A set of public web site URLs for the resource. */
    public var urls: [Url]?
    public var series: SeriesSummary?
    /** A list of variant issues for this comic (includes the \&quot;original\&quot; issue if the current issue is a variant). */
    public var variants: [ComicSummary]?
    /** A list of collections which include this comic (will generally be empty if the comic&#x27;s format is a collection). */
    public var collections: [ComicSummary]?
    /** A list of issues collected in this comic (will generally be empty for periodical formats such as \&quot;comic\&quot; or \&quot;magazine\&quot;). */
    public var collectedIssues: [ComicSummary]?
    /** A list of key dates for this comic. */
    public var dates: [ComicDate]?
    /** A list of prices for this comic. */
    public var prices: [ComicPrice]?
    public var thumbnail: Image?
    /** A list of promotional images associated with this comic. */
    public var images: [Image]?
    public var creators: CreatorList?
    public var characters: CharacterList?
    public var stories: StoryList?
    public var events: EventList?

    public init(_id: Int? = nil, digitalId: Int? = nil, title: String? = nil, issueNumber: Double? = nil, variantDescription: String? = nil, _description: String? = nil, modified: Date? = nil, isbn: String? = nil, upc: String? = nil, diamondCode: String? = nil, ean: String? = nil, issn: String? = nil, format: String? = nil, pageCount: Int? = nil, textObjects: [TextObject]? = nil, resourceURI: String? = nil, urls: [Url]? = nil, series: SeriesSummary? = nil, variants: [ComicSummary]? = nil, collections: [ComicSummary]? = nil, collectedIssues: [ComicSummary]? = nil, dates: [ComicDate]? = nil, prices: [ComicPrice]? = nil, thumbnail: Image? = nil, images: [Image]? = nil, creators: CreatorList? = nil, characters: CharacterList? = nil, stories: StoryList? = nil, events: EventList? = nil) {
        self._id = _id
        self.digitalId = digitalId
        self.title = title
        self.issueNumber = issueNumber
        self.variantDescription = variantDescription
        self._description = _description
        self.modified = modified
        self.isbn = isbn
        self.upc = upc
        self.diamondCode = diamondCode
        self.ean = ean
        self.issn = issn
        self.format = format
        self.pageCount = pageCount
        self.textObjects = textObjects
        self.resourceURI = resourceURI
        self.urls = urls
        self.series = series
        self.variants = variants
        self.collections = collections
        self.collectedIssues = collectedIssues
        self.dates = dates
        self.prices = prices
        self.thumbnail = thumbnail
        self.images = images
        self.creators = creators
        self.characters = characters
        self.stories = stories
        self.events = events
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case digitalId
        case title
        case issueNumber
        case variantDescription
        case _description = "description"
        case modified
        case isbn
        case upc
        case diamondCode
        case ean
        case issn
        case format
        case pageCount
        case textObjects
        case resourceURI
        case urls
        case series
        case variants
        case collections
        case collectedIssues
        case dates
        case prices
        case thumbnail
        case images
        case creators
        case characters
        case stories
        case events
    }

}

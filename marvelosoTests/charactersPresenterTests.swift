//
//  charactersPresenterTests.swift
//  marvelosoTests
//
//  Created by javimolla on 28/02/2021.
//

import XCTest
@testable import marveloso

class charactersPresenterTests: XCTestCase {
    var expectation: XCTestExpectation?
    
    override func setUpWithError() throws {
        expectation = XCTestExpectation(description: "Obtener los datos de algunos personajes")
    }

    override func tearDownWithError() throws {
    }

    func testGetSomeCharacters() throws {
        let presenter = CharactersPresenter(view: self, marvelService: MockMarvelService())
        presenter.loadCharacters(0)
        wait(for: [self.expectation!], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension charactersPresenterTests: CharactersView {
    func onCharactersRetrieved(_ characters: [CharacterSimple], _ totalCharacters: Int) {
        XCTAssertGreaterThan(totalCharacters, characters.count)
        self.expectation!.fulfill()
    }
    
    func onError(_ error: MarvelServiceError) {
        XCTAssertNil(error)
        self.expectation!.fulfill()
    }
}

class MockMarvelService: MarvelService {
    func getCharactersSimple(_ offset: Int,
                                      _ completion: @escaping ((_ characters: [CharacterSimple]?,
                                                                _ totalCharacters: Int?,
                                                                _ error: MarvelServiceError?) -> Void)) {
        completion([CharacterSimple(id: 1, name: "name", thumbnail: "thumbnail")], 100, nil)
    }
    
    func getCharacterDetail(_ id: Int,
                            _ completion: @escaping ((_ character: CharacterDetail?,
                                                      _ error: MarvelServiceError?) -> Void)) {
        // Not used
    }
}

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
        ServiceResolver.marvelService = MockMarvelService()
        expectation = XCTestExpectation(description: "Obtener los datos de algunos personajes")
    }

    override func tearDownWithError() throws {
    }

    func testGetSomeCharacters() throws {
        let presenter = CharactersPresenter(view: self)
        presenter.loadCharacters()
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
    func onCharactersRetrieved(_ newCharactersIndex: Int) {
        XCTAssertGreaterThan(newCharactersIndex, 0)
        self.expectation!.fulfill()
    }
    
    func onError(_ error: String) {
        XCTAssertNil(error)
        self.expectation!.fulfill()
    }
}

class MockMarvelService: MarvelService {
    func getCharactersSimple(_ offset: Int,
                             _ completion: @escaping ((_ characters: [CharacterSimple]?,
                                                       _ totalCharacters: Int?,
                                                       _ error: String?) -> Void)) {
        completion([CharacterSimple(id: 1, name: "name", thumbnail: "thumbnail")], 100, nil)
    }
    
    func getCharacterDetail(_ id: Int,
                            _ completion: @escaping ((_ character: CharacterDetail?,
                                                      _ error: String?) -> Void)) {
        // Not used
    }
}

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
        let presenter = CharactersPresenter(self)
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
    
    func onError(_ error: MarvelService.MarvelServiceError) {
        XCTAssertNil(error)
        self.expectation!.fulfill()
    }
}

//
//  marvelServiceTests.swift
//  marvelosoTests
//
//  Created by javimolla on 27/02/2021.
//

import XCTest
@testable import marveloso

class marvelServiceTests: XCTestCase {
    override func setUpWithError() throws {
        SwaggerClientAPI.publicKey = environmentVariables.marvelPublicKey
        SwaggerClientAPI.privateKey = environmentVariables.marvelPrivateKey
    }

    override func tearDownWithError() throws {
    }

    func testGetSomeCharacters() throws {
        let expectation = XCTestExpectation(description: "Obtener los datos de algunos personajes")
        
        MarvelService().getCharactersSimple(0) { (characters: [CharacterSimple]?,
                                                  totalCharacters: Int?,
                                                  error: String?) in
            XCTAssertNil(error)
            XCTAssertGreaterThan(totalCharacters!, characters!.count)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetOneCharacter() throws {
        let expectation = XCTestExpectation(description: "Obtener los datos de un personaje")
        
        let id = 1011334
        MarvelService().getCharacterDetail(id) { (character: CharacterDetail?,
                                                  error: String?) in
            XCTAssertNil(error)
            XCTAssertNotNil(character)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

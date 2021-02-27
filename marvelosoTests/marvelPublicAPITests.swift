//
//  MarvelPublicAPITests.swift
//  marvelosoTests
//
//  Created by javimolla on 27/02/2021.
//

import XCTest
@testable import marveloso

class marvelPublicAPITests: XCTestCase {
    override func setUpWithError() throws {
        SwaggerClientAPI.publicKey = environmentVariables.marvelPublicKey
        SwaggerClientAPI.privateKey = environmentVariables.marvelPrivateKey
    }

    override func tearDownWithError() throws {
    }

    func testGetSomeCharacters() throws {
        let expectation = XCTestExpectation(description: "Obtener los datos de algunos personajes")
        
        let limit = 10
        let offset = 0
        PublicAPI.getCreatorCollection(limit: limit, offset: offset) { (data: CharacterDataWrapper?,
                                                                   error: Error?) in
            
            XCTAssertNil(error)
            XCTAssertEqual(limit, data!.data!.count!)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetOneCharacter() throws {
        let expectation = XCTestExpectation(description: "Obtener los datos de un personaje")
        
        let id = 1011334
        PublicAPI.getCharacterIndividual(characterId: id) { (data: CharacterDataWrapper?,
                                                             error: Error?) in
            
            XCTAssertNil(error)
            XCTAssertEqual(1, data!.data!.count!)
            
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

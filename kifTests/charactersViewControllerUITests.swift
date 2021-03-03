//
//  charactersViewControllerUITests.swift
//  marvelosoUITests
//
//  Created by javimolla on 28/02/2021.
//

import XCTest
@testable import marveloso

class charactersViewControllerUITests: AcceptanceTestCase {
    override func beforeAll() {
        ServiceResolver.marvelService = MockMarvelService()
    }
    
    func testShowsSomeCharacters() {
        let viewController = getViewController()
        loadViewController(viewController)
        checkFirstCharacter(viewController)
    }
    
    private func getViewController() -> CharactersViewController {
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CharactersViewController") as! CharactersViewController
    }
    
    private func loadViewController(_ viewController: UIViewController) {
        viewController.loadView()
        present(viewController: viewController)
        tester().waitForAnimationsToFinish()
    }
    
    private func checkFirstCharacter(_ viewController: CharactersViewController) {
        let cell: CharacterCellView? = tester().usingTimeout(10)
            .waitForCell(at: IndexPath(row: 0, section: 0), in: viewController.tableView) as? CharacterCellView
        XCTAssertNotNil(cell!)
        XCTAssertEqual(cell!.nameLabel.text, "name")
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

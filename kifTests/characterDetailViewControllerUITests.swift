//
//  characterDetailViewControllerUITests.swift
//  marvelosoUITests
//
//  Created by javimolla on 28/02/2021.
//

import XCTest
@testable import marveloso

class characterDetailViewControllerUITests: AcceptanceTestCase {
    override func beforeAll() {
        ServiceResolver.marvelService = MockMarvelService()
    }
    
    func testShowsOneCharacterDetail() {
        let viewController = getViewController()
        loadViewController(viewController)
        checkCharacter(viewController)
    }
    
    private func getViewController() -> CharacterDetailViewController {
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
    }
    
    private func loadViewController(_ viewController: UIViewController) {
        viewController.loadView()
        present(viewController: viewController)
        tester().waitForAnimationsToFinish()
    }
    
    private func checkCharacter(_ viewController: CharacterDetailViewController) {
        let descriptionLabel: UILabel? = tester().usingTimeout(10).waitForView(withAccessibilityLabel: "descriptionLabel") as? UILabel
        XCTAssertNotNil(descriptionLabel!)
        XCTAssertEqual(descriptionLabel!.text, "description")
    }
}

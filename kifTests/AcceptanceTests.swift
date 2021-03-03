//
//  AcceptanceTests.swift
//  marvelosoUITests
//
//  Created by javimolla on 28/02/2021.
//

import Foundation
import KIF

class AcceptanceTestCase: KIFTestCase {
    fileprivate var originalRootViewController: UIViewController?
    fileprivate var rootViewController: UIViewController? {
        get {
            return getKeyWindow()?.rootViewController
        }

        set(newRootViewController) {
            getKeyWindow()?.rootViewController = newRootViewController
        }
    }

    override func tearDown() {
        super.tearDown()
        if let originalRootViewController = originalRootViewController {
            rootViewController = originalRootViewController
        }
    }

    func present(viewController: UIViewController) {
        originalRootViewController = rootViewController
        rootViewController = viewController
    }
    
    private func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}

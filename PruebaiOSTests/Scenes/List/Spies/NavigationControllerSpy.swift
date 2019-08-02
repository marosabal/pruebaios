//
//  NavigationControllerSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

import UIKit

class NavigationControllerSpy: UINavigationController {

    private(set) var isPushViewControllerCalled = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)

        isPushViewControllerCalled = true
    }

}

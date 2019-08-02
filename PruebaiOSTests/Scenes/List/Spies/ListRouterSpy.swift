//
//  ListRouterSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import UIKit

class ListRouterSpy: ListRouter {

    private(set) var isRouteToMovieDetailsCalled = false

    override func routeToMovieDetails() {
        isRouteToMovieDetailsCalled = true
    }
}

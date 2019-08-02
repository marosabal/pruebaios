//
//  ListRouterTests.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class ListRouterTests: XCTestCase {

    // MARK: - Subject under test
    var sut: ListRouter?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupSut()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupSut() {
        sut = ListRouter()
    }

    func testPassDataToDetails() {
        var source: ListDataStore = ListDataStoreSpy()
        source.selectedMovie = ListWorkerSpy().loadTestResponse().results[0]
        var destination: DetailsDataStore = DetailsDataStoreSpy()
        sut?.passDataToDetails(source: source, destination: &destination)
        XCTAssertNotNil(destination.selectedMovie)
        XCTAssertEqual(destination.selectedMovie!.id, source.selectedMovie!.id)
    }

    func testRouteToMovieDetails() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "ListViewController"
            ) as? ListViewController
        let navigationController = NavigationControllerSpy(
            rootViewController: viewController!
        )
        sut?.dataStore = ListDataStoreSpy()
        sut?.viewController = viewController
        sut?.routeToMovieDetails()
        XCTAssertTrue(navigationController.isPushViewControllerCalled)
    }

    // MARK: - Mocks

    class ListDataStoreSpy: ListDataStore {
        var selectedMovie: Result?
    }

    class DetailsDataStoreSpy: DetailsDataStore {
        var selectedMovie: Result?
    }
}

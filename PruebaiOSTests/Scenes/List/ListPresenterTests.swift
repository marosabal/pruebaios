//
//  ListPresenterTests.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class ListPresenterTests: XCTestCase {

    // MARK: - Subject under test
    var viewController: ListDisplayLogicSpy?
    var sut: ListPresenter?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupSut()
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupSut() {
        viewController = ListDisplayLogicSpy()
        sut = ListPresenter()
        sut?.viewController = viewController
    }

    // MARK: - Tests

    func testParseResults() {
        let firstResult = ListWorkerSpy().loadTestResponse().results.first!
        let results = sut!.parseResults(results: [firstResult])
        XCTAssertEqual(results[0].id, firstResult.id)
        XCTAssertEqual(results[0].title, firstResult.title)
        XCTAssertEqual(results[0].imageURL, "\(ApiKeys.imageUrl200.rawValue)\(firstResult.posterPath ?? "")")
    }

    func testPresentMovies() {
        let results = ListWorkerSpy().loadTestResponse().results
        let response: List.Movies.Response = .init(results: results)
        sut?.presentMovies(response: response)
        XCTAssertTrue(viewController!.isDisplayResultsCalled)

        let firstResult = results[0]
        let firstViewModel = viewController!.displayResultsViewModel.results[0]
        XCTAssertEqual(firstViewModel.id, firstResult.id)
        XCTAssertEqual(firstViewModel.title, firstResult.title)
        XCTAssertEqual(firstViewModel.imageURL, "\(ApiKeys.imageUrl200.rawValue)\(firstResult.posterPath ?? "")")
    }

    func testPresentError() {
        let response: List.Error.Response = .init(message: "some error message")
        sut?.presentError(response: response)
        XCTAssertTrue(viewController!.isDisplayErrorCalled)
    }

    func testPresentMoreMovies() {
        let results = ListWorkerSpy().loadTestResponse().results
        let response: List.MoreMovies.Response = .init(results: results)
        sut?.presentMoreMovies(response: response)
        XCTAssertTrue(viewController!.isDisplayMoreMoviesCalled)

        let firstResult = results[0]
        let firstViewModel = viewController!.displayMoreMoviesViewModel.results[0]
        XCTAssertEqual(firstViewModel.id, firstResult.id)
        XCTAssertEqual(firstViewModel.title, firstResult.title)
        XCTAssertEqual(firstViewModel.imageURL, "\(ApiKeys.imageUrl200.rawValue)\(firstResult.posterPath ?? "")")
    }

    func testPresentMoreMoviesEmpty() {
        let response: List.MoreMovies.Response = .init(results: [])
        sut?.presentMoreMovies(response: response)
        XCTAssertFalse(viewController!.isDisplayMoreMoviesCalled)
    }

    func testPresentSelectedMovie() {
        sut?.presentSelectedMovie()
        XCTAssertTrue(viewController!.isDisplaySelectedMovieCalled)
    }
}

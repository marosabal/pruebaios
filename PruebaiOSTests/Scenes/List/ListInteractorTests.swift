//
//  ListInteractorTests.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class ListInteractorTests: XCTestCase {

    // MARK: - Subject under test

    var sut: ListInteractor?
    var worker: ListWorkerSpy?
    var presenter: ListPresentationLogicSpy?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupSut()
    }

    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupSut() {
        presenter = ListPresentationLogicSpy()
        worker = ListWorkerSpy()
        sut = ListInteractor()
        sut?.worker = worker
        sut?.presenter = presenter
    }

    // MARK: - Tests

    func testNextPage() {
        sut?.page = 0
        sut?.totalPages = 10
        let result = sut?.nextPage()
        XCTAssertTrue(result!)
    }

    func testNextPageFalse() {
        sut?.page = 10
        sut?.totalPages = 10
        let result = sut?.nextPage()
        XCTAssertFalse(result!)
    }

    func testViewDidLoad() {
        worker?.isSuccess = true
        sut?.viewDidLoad()
        XCTAssertTrue(worker!.isGetMovieListCalled)
        wait(for: [], timeout: 10)
        XCTAssertTrue(presenter!.isPresentMoviesCalled)
    }

    func testViewDidLoadError() {
        worker?.isSuccess = false
        sut?.viewDidLoad()
        XCTAssertTrue(worker!.isGetMovieListCalled)
        wait(for: [], timeout: 10)
        XCTAssertFalse(presenter!.isPresentMoviesCalled)
        XCTAssertTrue(presenter!.isPresentErrorCalled)
    }

    func testViewDidLoadNextPageFalse() {
        sut?.page = 10
        sut?.totalPages = 10
        sut?.viewDidLoad()
        XCTAssertFalse(presenter!.isPresentErrorCalled)
        XCTAssertFalse(presenter!.isPresentMoviesCalled)
    }

    func testLoadNextPage() {
        worker?.isSuccess = true
        sut?.loadNextPage()
        XCTAssertTrue(worker!.isGetMovieListCalled)
        wait(for: [], timeout: 10)
        XCTAssertTrue(presenter!.isPresentMoreMoviesCalled)
    }

    func testLoadNextPageFalse() {
        sut?.page = 10
        sut?.totalPages = 10
        sut?.loadNextPage()
        XCTAssertFalse(presenter!.isPresentMoviesCalled)
    }

    func testSelectedMovie() {
        let request: List.SelectedMovie.Request = .init(id: 10)
        sut?.results = worker?.loadTestResponse().results ?? []
        sut?.selectedMovie(request: request)
        XCTAssertTrue(presenter!.isPresentSelectedMovieCalled)
    }
}

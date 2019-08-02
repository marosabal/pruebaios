//
//  DetailsInteractorTests.swift
//  PruebaiOS
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class DetailsInteractorTests: XCTestCase {
    
    // MARK: - Subject under test

    var presenter: DetailsPresentationLogicSpy?
    var sut: DetailsInteractor?
    var worker: DetailsWorkerSpy?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupDetailsInteractor()
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupDetailsInteractor() {
        presenter = .init()
        worker = .init()
        sut = DetailsInteractor()
        sut?.presenter = presenter
        sut?.worker = worker
    }
    
    // MARK: - Tests

    func testViewDidLoadNotId() {
        sut?.viewDidLoad()
        XCTAssertFalse(presenter!.isPresentMovieCalled)
    }

    func testViewDidLoad() {
        worker?.isSuccess = true
        sut?.selectedMovie = ListWorkerSpy().loadTestResponse().results[0]
        sut?.viewDidLoad()
        wait(for: [], timeout: 10)
        XCTAssertTrue(worker!.isGetMovieDetailsCalled)
        XCTAssertTrue(presenter!.isPresentMovieCalled)
        XCTAssertFalse(presenter!.isPresentErrorCalled)
    }

    func testProcessError() {
        let error = NSError(domain: "some test error", code: 500, userInfo: nil)
        sut?.processError(error: error)
        XCTAssertTrue(presenter!.isPresentErrorCalled)
        XCTAssertEqual(
            presenter?.presentErrorResponse.message,
            error.localizedDescription
        )
    }

    func testProcessResponse() {
        let response = worker!.loadTestResponse()
        sut?.processResponse(response: response)
        XCTAssertTrue(presenter!.isPresentMovieCalled)
        XCTAssertEqual(response.id, presenter!.presentMovieResponse.response.id)
    }
}

//
//  DetailsWorkerTests.swift
//  PruebaiOS
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class DetailsWorkerTests: XCTestCase {

    // MARK: - Subject under test

    var api: ServicesProtocolSpy?
    var sut: DetailsWorker?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupDetailsWorker()
    }

    override func tearDown() {
        sut = nil
        api = nil
        super.tearDown()
    }
    
    // MARK: - Test setup

    func setupDetailsWorker() {
        api = .init()
        sut = DetailsWorker(api!)
    }

    // MARK: - Tests

    func testGetMovieDetails() {
        api?.isSuccess = true
        api?.handlerData = DetailsWorkerSpy().loadTestData()
        let expectation = XCTestExpectation(description: "getMovieDetails request")
        sut?.getMovieDetails(id: 420818) { response, error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(api!.isGetMovieDetailsCalled)
    }

    func testGetMovieListError() {
        api?.isSuccess = false
        let expectation = XCTestExpectation(description: "getMovieDetails request fail")
        sut?.getMovieDetails(id: 420818) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(api!.isGetMovieDetailsCalled)
    }
}

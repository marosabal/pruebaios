//
//  ListWorkerTests.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class ListWorkerTests: XCTestCase {

    // MARK: - Subject under test

    var api: ServicesProtocolSpy?
    var sut: ListWorker?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupSut()
    }

    override func tearDown() {
        sut = nil
        api = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupSut() {
        api = .init()
        sut = ListWorker(api!)
    }

    // MARK: - Tests

    func testGetMovieList() {
        api?.isSuccess = true
        api?.handlerData = ListWorkerSpy().loadTestData()
        let expectation = XCTestExpectation(description: "getMovieList request")
        sut?.getMovieList(page: 1) { response, error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(api!.isGetMovieListCalled)
    }

    func testGetMovieListError() {
        api?.isSuccess = false
        let expectation = XCTestExpectation(description: "getMovieList request fail")
        sut?.getMovieList(page: 1) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(api!.isGetMovieListCalled)
    }
}

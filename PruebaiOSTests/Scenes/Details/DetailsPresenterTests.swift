//
//  DetailsPresenterTests.swift
//  PruebaiOS
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class DetailsPresenterTests: XCTestCase {

    // MARK: - Subject under test

    var sut: DetailsPresenter?
    var viewController: DetailsDisplayLogicSpy?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupDetailsPresenter()
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupDetailsPresenter() {
        viewController = .init()
        sut = DetailsPresenter()
        sut?.viewController = viewController
    }

    // MARK: - Tests

    func testPresentError() {
        let response: Details.Error.Response = .init(message: "some error message")
        sut?.presentError(response: response)
        XCTAssertTrue(viewController!.isDisplayErrorCalled)
    }

    func testPresentMovie() {
        let movieDetailResponse: MovieDetailResponse = DetailsWorkerSpy().loadTestResponse()
        let response: Details.Movie.Response = .init(response: movieDetailResponse)
        sut?.presentMovie(response: response)
        XCTAssertTrue(viewController!.isDisplayMovieCalled)

        let details: [String] = response.response.genres?.map { $0.name } ?? []
        var backdropPath = response.response.backdropPath ?? ""
        if backdropPath.isEmpty {
            backdropPath = response.response.posterPath ?? ""
        }

        var releaseDateString = ""
        if let releaseDate = response.response.releaseDate {
            let formatter: DateFormatter = .init()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: releaseDate) {
                formatter.dateStyle = .medium
                releaseDateString = "Release date: \(formatter.string(from: date))"
            }
        }

        XCTAssertEqual(
            movieDetailResponse.originalTitle,
            viewController!.displayMovieViewModel.title
        )
        XCTAssertEqual(
            movieDetailResponse.overview ?? "",
            viewController!.displayMovieViewModel.overview
        )
        XCTAssertEqual(
            "\(ApiKeys.imageUrl500.rawValue)\(backdropPath)",
            viewController!.displayMovieViewModel.imageUrl
        )
        XCTAssertEqual(
            details.joined(separator: " ‧ "),
            viewController!.displayMovieViewModel.details
        )
        XCTAssertEqual(
            releaseDateString,
            viewController!.displayMovieViewModel.releaseDate
        )
    }
}

//
//  ListViewControllerTests.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class ListViewControllerTests: XCTestCase {

    // MARK: - Subject under test
    var sut: ListViewController?
    var router: ListRouterSpy?
    var interactor: ListBusinessLogicSpy?
    var window: UIWindow?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        window = .init()
        setupSut()
    }

    override func tearDown() {
        window = nil
        sut = nil
        interactor = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupSut() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
        interactor = .init()
        router = .init()
        sut?.interactor = interactor
        sut?.router = router
    }

    func loadView() {
        window?.addSubview(sut!.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Tests

    func testViewDidLoad() {
        loadView()
        XCTAssert(interactor!.isViewDidLoadCalled)
    }

    func testDisplayResults() {
        let movieInfo: MovieInfo = .init(id: 1, title: "test", imageURL: "")
        let viewModel: List.Movies.ViewModel = .init(results: [movieInfo])
        loadView()
        sut?.displayResults(viewModel: viewModel)
        XCTAssertEqual(sut!.results[0].id, movieInfo.id)
        XCTAssertEqual(sut!.results[0].title, movieInfo.title)
    }

    func testDisplayError() {
        let viewModel: List.Error.ViewModel = .init(message: "some error")
        loadView()
        sut?.displayError(viewModel: viewModel)
        XCTAssertNotNil(sut?.presentedViewController)
    }

    func testDisplayMoreMovies() {
        sut?.results = [MovieInfo(id: 1, title: "test 1", imageURL: "")]
        let movieInfo: MovieInfo = .init(id: 2, title: "test 2", imageURL: "")
        let viewModel: List.MoreMovies.ViewModel = .init(results: [movieInfo])
        loadView()
        sut?.displayMoreMovies(viewModel: viewModel)
        XCTAssertEqual(sut!.results.count, 2)
        XCTAssertEqual(sut!.results[1].id, movieInfo.id)
        XCTAssertEqual(sut!.results[1].title, movieInfo.title)
    }

    func testDisplaySelectedMovie() {
        sut?.displaySelectedMovie()
        XCTAssertTrue(router!.isRouteToMovieDetailsCalled)
    }

    func testTableViewDidSelect() {
        sut?.results = [MovieInfo(id: 1, title: "test 1", imageURL: "")]
        sut?.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(interactor!.isSelectedMovieCalled)
    }
}

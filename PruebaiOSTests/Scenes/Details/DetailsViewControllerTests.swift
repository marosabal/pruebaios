//
//  DetailsViewControllerTests.swift
//  PruebaiOS
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import PruebaiOS
import XCTest

class DetailsViewControllerTests: XCTestCase {

    // MARK: - Subject under test
    var sut: DetailsViewController?
    var interactor: DetailsBusinessLogicSpy?
    var window: UIWindow?

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        window = .init()
        setupDetailsViewController()
    }

    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test setup
    
    func setupDetailsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Details", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        interactor = .init()
        sut?.interactor = interactor
    }

    func loadView() {
        window?.addSubview(sut!.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Tests

    func testViewDidLoad() {
        loadView()
        sut?.viewDidLoad()
        XCTAssertTrue(interactor!.isViewDidLoadCalled)
    }

    func testDisplayError() {
        let viewModel: Details.Error.ViewModel = .init(message: "some error")
        loadView()
        sut?.displayError(viewModel: viewModel)
        XCTAssertNotNil(sut?.presentedViewController)
    }

    func testDisplayMovie() {
        loadView()
        let viewModel: Details.Movie.ViewModel = .init(
            title: "title ...",
            overview: "overview ...",
            details: "details ...",
            imageUrl: "imageUrl ...",
            releaseDate: "releaseDate ..."
        )
        sut?.displayMovie(viewModel: viewModel)
        XCTAssertEqual(sut!.movieTitle()!, viewModel.title)
        XCTAssertEqual(sut!.movieDetails()!, viewModel.details)
        XCTAssertEqual(sut!.movieOverview()!, viewModel.overview)
        XCTAssertEqual(sut!.movieReleaseDate()!, viewModel.releaseDate)
    }
}

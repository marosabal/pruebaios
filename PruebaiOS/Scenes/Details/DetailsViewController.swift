//
//  DetailsViewController.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func displayMovie(viewModel: Details.Movie.ViewModel)
    func displayError(viewModel: Details.Error.ViewModel)
}

class DetailsViewController: UIViewController, DetailsDisplayLogic {
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?

    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Outlets
    @IBOutlet private weak var imageViewPoster: UIImageView?
    @IBOutlet private weak var labelTitle: UILabel?
    @IBOutlet private weak var labelDetails: UILabel?
    @IBOutlet private weak var labelOverView: UILabel?
    @IBOutlet private weak var labelReleaseDate: UILabel?

    // MARK: - Attributes

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - Private

    func setupView() {
        imageViewPoster?.clipsToBounds = true
        imageViewPoster?.layer.cornerRadius = 8
    }

    // MARK: - Testing

    func movieTitle() -> String? {
        return labelTitle?.text
    }

    func movieDetails() -> String? {
        return labelDetails?.text
    }

    func movieOverview() -> String? {
        return labelOverView?.text
    }

    func movieReleaseDate() -> String? {
        return labelReleaseDate?.text
    }

    // MARK: - DetailsDisplayLogic

    func displayMovie(viewModel: Details.Movie.ViewModel) {
        labelTitle?.text = viewModel.title
        labelDetails?.text = viewModel.details
        labelOverView?.text = viewModel.overview
        imageViewPoster?.fetch(from: viewModel.imageUrl)
        labelReleaseDate?.text = viewModel.releaseDate
    }

    func displayError(viewModel: Details.Error.ViewModel) {

        let alertController = UIAlertController(title: viewModel.message, message: nil, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.modalPresentationStyle = .popover
            alertController.popoverPresentationController?.sourceView = view
            alertController.popoverPresentationController?.sourceRect = view.bounds
        }

        present(alertController, animated: true, completion: nil)
    }
}

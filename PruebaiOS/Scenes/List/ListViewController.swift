//
//  ListViewController.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol ListDisplayLogic: AnyObject {
    func displayResults(viewModel: List.Movies.ViewModel)
    func displayError(viewModel: List.Error.ViewModel)
    func displayMoreMovies(viewModel: List.MoreMovies.ViewModel)
    func displaySelectedMovie()
}

class ListViewController: UITableViewController, ListDisplayLogic {
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?

    // MARK: - Object lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Outlets

    // MARK: - Attributes
    var results: [List.MovieData] = []

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Private

    func setupView() {
        title = "Movies"
        tableView.tableFooterView = UIView()
    }

    // MARK: - ListDisplayLogic

    func displayResults(viewModel: List.Movies.ViewModel) {
        results = viewModel.results
        tableView.reloadData()
    }

    func displayError(viewModel: List.Error.ViewModel) {

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

    func displayMoreMovies(viewModel: List.MoreMovies.ViewModel) {
        var indexPaths: [IndexPath] = []
        let count = results.count
        for (index, item) in viewModel.results.enumerated() {
            indexPaths.append(IndexPath(row: count + index, section: 0))
            results.append(item)
        }

        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .none)
        tableView.endUpdates()
    }

    func displaySelectedMovie() {
        router?.routeToMovieDetails()
    }

    // MARK: - UITableViewDataStore

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "movieCell", for: indexPath
            ) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(info: results[indexPath.item])

        if indexPath.item > results.count - 10 {
            interactor?.loadNextPage()
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = results[indexPath.item]
        let request: List.SelectedMovie.Request = .init(
            id: movie.id
        )
        interactor?.selectedMovie(request: request)
    }
}

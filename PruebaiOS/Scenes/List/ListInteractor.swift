//
//  ListInteractor.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol ListBusinessLogic {
    func viewDidLoad()
    func loadNextPage()
    func selectedMovie(request: List.SelectedMovie.Request)
}

protocol ListDataStore {
    var selectedMovie: Result? { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {

    var presenter: ListPresentationLogic?
    var worker: ListWorkerProtocol?
    var page: Int = 0
    var totalPages: Int = Int.max
    var results: [Result] = []

    init() {
        worker = ListWorker()
    }

    // MARK: - ListDataStore
    var selectedMovie: Result?
    
    // MARK: - ListBusinessLogic

    func nextPage() -> Bool {
        page += 1
        return page < totalPages
    }

    func viewDidLoad() {

        if !nextPage() {
            return
        }

        worker?.getMovieList(page: page) { [weak self] response, error in
            self?.totalPages = response?.totalPages ?? 0

            self?.results = response?.results ?? []

            let response: List.Movies.Response = .init(
                results: response?.results ?? []
            )
            self?.presenter?.presentMovies(response: response)
        }

    }

    func loadNextPage() {

        if !nextPage() {
            return
        }

        worker?.getMovieList(page: page) { response, _ in
            self.results.append(contentsOf: response?.results ?? [])
            let response: List.MoreMovies.Response = .init(
                results: response?.results ?? []
            )
            self.presenter?.presentMoreMovies(response: response)
        }

    }

    func selectedMovie(request: List.SelectedMovie.Request) {
        selectedMovie = results.first { movie -> Bool in
            return movie.id == request.id
        }
        presenter?.presentSelectedMovie()
    }
}

//
//  DetailsInteractor.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol DetailsBusinessLogic {
    func viewDidLoad()
}

protocol DetailsDataStore {
    var selectedMovie: Result? { get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkerProtocol?

    init() {
        worker = DetailsWorker()
    }

    // MARK: - DetailsDataStore
    var selectedMovie: Result?

    // MARK: - DetailsBusinessLogic

    func viewDidLoad() {

        guard let id = selectedMovie?.id else {
            return
        }

        worker?.getMovieDetails(id: id) { [weak self] response, error in
            if let error = error {
                self?.processError(error: error)
                return
            }
            if let response = response {
                self?.processResponse(response: response)
            }
        }

    }

    func processError(error: Error) {
        let response: Details.Error.Response = .init(
            message: error.localizedDescription
        )
        presenter?.presentError(response: response)
    }

    func processResponse(response: MovieDetailResponse) {
        let response: Details.Movie.Response = .init(
            response: response
        )
        presenter?.presentMovie(response: response)
    }

}

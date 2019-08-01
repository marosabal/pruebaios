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
    var worker: DetailsWorker?

    // MARK: - DetailsDataStore
    var selectedMovie: Result?
    
    // MARK: - DetailsBusinessLogic

    func viewDidLoad() {
        let response: Details.Movie.Response = .init(
            title: selectedMovie?.title ?? ""
        )
        presenter?.presentMovie(response: response)
    }

}

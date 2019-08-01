//
//  ListPresenter.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol ListPresentationLogic {
    func presentMovies(response: List.Movies.Response)
    func presentError(response: List.Error.Response)
    func presentMoreMovies(response: List.MoreMovies.Response)
    func presentSelectedMovie()
}

class ListPresenter: ListPresentationLogic {
    weak var viewController: ListDisplayLogic?

    func parseResults(results: [Result]) -> [MovieInfo] {
        return results.map{
            MovieInfo(
                id: $0.id,
                title: $0.title,
                imageURL: "\(ApiKeys.imageUrl.rawValue)\($0.posterPath ?? "")"
            )
        }
    }
    
    // MARK: - ListPresentationLogic

    func presentMovies(response: List.Movies.Response) {
        let viewModel: List.Movies.ViewModel = .init(
            results: parseResults(results: response.results)
        )
        viewController?.displayResults(viewModel: viewModel)
    }

    func presentError(response: List.Error.Response) {
        let viewModel: List.Error.ViewModel = .init(
            message: response.message
        )
        viewController?.displayError(viewModel: viewModel)
    }

    func presentMoreMovies(response: List.MoreMovies.Response) {
        if response.results.isEmpty {
            return
        }
        let viewModel: List.MoreMovies.ViewModel = .init(
            results: parseResults(results: response.results)
        )
        viewController?.displayMoreMovies(viewModel: viewModel)
    }

    func presentSelectedMovie() {
        viewController?.displaySelectedMovie()
    }
    
}

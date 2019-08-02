//
//  DetailsPresenter.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol DetailsPresentationLogic {
    func presentMovie(response: Details.Movie.Response)
    func presentError(response: Details.Error.Response)
}

class DetailsPresenter: DetailsPresentationLogic {
    weak var viewController: DetailsDisplayLogic?

    // MARK: - DetailsPresentationLogic

    func presentMovie(response: Details.Movie.Response) {

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

        let viewModel: Details.Movie.ViewModel = .init(
            title: response.response.originalTitle,
            overview: response.response.overview ?? "",
            details: details.joined(separator: " ‧ "),
            imageUrl: "\(ApiKeys.imageUrl500.rawValue)\(backdropPath)",
            releaseDate: releaseDateString
        )
        viewController?.displayMovie(viewModel: viewModel)
    }

    func presentError(response: Details.Error.Response) {
        let viewModel: Details.Error.ViewModel = .init(
            message: response.message
        )
        viewController?.displayError(viewModel: viewModel)
    }
}

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
}

class DetailsPresenter: DetailsPresentationLogic {
    weak var viewController: DetailsDisplayLogic?
    
    // MARK: - DetailsPresentationLogic

    func presentMovie(response: Details.Movie.Response) {
        let viewModel: Details.Movie.ViewModel = .init(
            title: response.title
        )
        viewController?.displayMovie(viewModel: viewModel)
    }
}

//
//  DetailsDisplayLogicSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS

class DetailsDisplayLogicSpy: DetailsDisplayLogic {

    private(set) var isDisplayMovieCalled = false
    private(set) var isDisplayErrorCalled = false
    private(set) var displayMovieViewModel: Details.Movie.ViewModel!
    private(set) var displayErrorViewModel: Details.Error.ViewModel!

    func displayMovie(viewModel: Details.Movie.ViewModel) {
        isDisplayMovieCalled = true
        displayMovieViewModel = viewModel
    }

    func displayError(viewModel: Details.Error.ViewModel) {
        isDisplayErrorCalled = true
        displayErrorViewModel = viewModel
    }


}

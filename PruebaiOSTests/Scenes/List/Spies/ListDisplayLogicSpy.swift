//
//  ListDisplayLogicSpy.swift
//  PruebaiOSUITests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS

class ListDisplayLogicSpy: ListDisplayLogic {

    private(set) var isDisplayResultsCalled = false
    private(set) var isDisplayErrorCalled = false
    private(set) var isDisplayMoreMoviesCalled = false
    private(set) var isDisplaySelectedMovieCalled = false
    private(set) var displayResultsViewModel: List.Movies.ViewModel!
    private(set) var displayErrorViewModel: List.Error.ViewModel!
    private(set) var displayMoreMoviesViewModel: List.MoreMovies.ViewModel!

    func displayResults(viewModel: List.Movies.ViewModel) {
        displayResultsViewModel = viewModel
        isDisplayResultsCalled = true
    }

    func displayError(viewModel: List.Error.ViewModel) {
        displayErrorViewModel = viewModel
        isDisplayErrorCalled = true
    }

    func displayMoreMovies(viewModel: List.MoreMovies.ViewModel) {
        displayMoreMoviesViewModel = viewModel
        isDisplayMoreMoviesCalled = true
    }

    func displaySelectedMovie() {
        isDisplaySelectedMovieCalled = true
    }

}

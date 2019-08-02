//
//  ListPresentationLogicSpy.swift
//  PruebaiOSUITests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS

class ListPresentationLogicSpy: ListPresentationLogic {

    private(set) var isPresentMoviesCalled = false
    private(set) var isPresentErrorCalled = false
    private(set) var isPresentMoreMoviesCalled = false
    private(set) var isPresentSelectedMovieCalled = false
    private(set) var presentMoviesResponse: List.Movies.Response!
    private(set) var presentErrorResponse: List.Error.Response!
    private(set) var presentMoreMoviesResponse: List.MoreMovies.Response!

    func presentMovies(response: List.Movies.Response) {
        presentMoviesResponse = response
        isPresentMoviesCalled = true
    }

    func presentError(response: List.Error.Response) {
        presentErrorResponse = response
        isPresentErrorCalled = true
    }

    func presentMoreMovies(response: List.MoreMovies.Response) {
        presentMoreMoviesResponse = response
        isPresentMoreMoviesCalled = true
    }

    func presentSelectedMovie() {
        isPresentSelectedMovieCalled = true
    }

}

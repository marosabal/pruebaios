//
//  DetailsPresentationLogicSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS

class DetailsPresentationLogicSpy: DetailsPresentationLogic {

    private(set) var isPresentMovieCalled = false
    private(set) var isPresentErrorCalled = false
    private(set) var presentMovieResponse: Details.Movie.Response!
    private(set) var presentErrorResponse: Details.Error.Response!

    func presentMovie(response: Details.Movie.Response) {
        isPresentMovieCalled = true
        presentMovieResponse = response
    }

    func presentError(response: Details.Error.Response) {
        isPresentErrorCalled = true
        presentErrorResponse = response
    }

}

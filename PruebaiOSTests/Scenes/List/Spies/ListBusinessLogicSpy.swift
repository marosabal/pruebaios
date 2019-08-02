//
//  ListDisplayLogicSpy.swift
//  PruebaiOSUITests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS

class ListBusinessLogicSpy: ListBusinessLogic {

    private(set) var isViewDidLoadCalled = false
    private(set) var isLoadNextPageCalled = false
    private(set) var isSelectedMovieCalled = false

    func viewDidLoad() {
        isViewDidLoadCalled = true
    }

    func loadNextPage() {
        isLoadNextPageCalled = true
    }

    func selectedMovie(request: List.SelectedMovie.Request) {
        isSelectedMovieCalled = true
    }

}

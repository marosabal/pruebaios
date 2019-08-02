//
//  DetailsBusinessLogicSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS

class DetailsBusinessLogicSpy: DetailsBusinessLogic {

    private(set) var isViewDidLoadCalled = true

    func viewDidLoad() {
        isViewDidLoadCalled = true
    }
    
}

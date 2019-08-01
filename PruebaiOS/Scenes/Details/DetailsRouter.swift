//
//  DetailsRouter.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

@objc protocol DetailsRoutingLogic {
}

protocol DetailsDataPassing {
    var dataStore: DetailsDataStore? { get }
}

class DetailsRouter: NSObject, DetailsRoutingLogic, DetailsDataPassing {
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    
    // MARK: - Routing
    
    // MARK: - Navigation
    
    //func navigateToSomewhere(source: DetailsViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: - Passing data
    
    //func passDataToSomewhere(source: DetailsDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

//
//  ListRouter.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

@objc protocol ListRoutingLogic {
    func routeToMovieDetails()
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

class ListRouter: NSObject, ListRoutingLogic, ListDataPassing {
    weak var viewController: ListViewController?
    var dataStore: ListDataStore?
    
    // MARK: - Routing

    func routeToMovieDetails() {
        let storyBoard = UIStoryboard(name: "Details", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(
            withIdentifier: "DetailsViewController"
            ) as! DetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetails(source: dataStore!, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToDetails(source: ListDataStore, destination: inout DetailsDataStore) {
      destination.selectedMovie = source.selectedMovie
    }
}

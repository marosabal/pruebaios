//
//  ListWorker.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import Foundation

protocol ListWorkerProtocol {
    func getMovieList(page: Int, handler: @escaping (DiscoveryResponse?, Error?) -> Void)
}

class ListWorker: ListWorkerProtocol {

    let api: MovieManagerProtocol?

    init(_ api: MovieManagerProtocol = MovieManager()) {
        self.api = api
    }

    func getMovieList(page: Int, handler: @escaping (DiscoveryResponse?, Error?) -> Void) {

        api?.getMovieList(page: page) { data, error in
            if let jsonData = data {
                let response = try? JSONDecoder().decode(DiscoveryResponse.self, from: jsonData)
                handler(response, error)
            } else {
                handler(nil, error)
            }
        }

    }

}

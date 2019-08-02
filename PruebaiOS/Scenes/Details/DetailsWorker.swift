//
//  DetailsWorker.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol DetailsWorkerProtocol {
    func getMovieDetails(id: Int, handler: @escaping (MovieDetailResponse?, Error?) -> Void)
}

class DetailsWorker: DetailsWorkerProtocol {

    let api: MovieManagerProtocol?

    init(_ api: MovieManagerProtocol = MovieManager()) {
        self.api = api
    }

    func getMovieDetails(id: Int, handler: @escaping (MovieDetailResponse?, Error?) -> Void) {

        api?.getMovieDetails(id: id) { data, error in
            if let jsonData = data {
                let response = try? JSONDecoder().decode(MovieDetailResponse.self, from: jsonData)
                handler(response, error)
            } else {
                handler(nil, error)
            }
        }

    }

}

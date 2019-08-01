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

    let api: ServicesProtocol?

    init(_ api: ServicesProtocol = Services()) {
        self.api = api
    }

    func getMovieList(page: Int, handler: @escaping (DiscoveryResponse?, Error?) -> Void) {

        let url = URL(string: ApiKeys.url.rawValue)!
        let parameters: [String: String] = [
            "api_key": ApiKeys.apiKey.rawValue,
            "language": "en-US",
            "sort_by": "popularity.desc",
            "include_adult": "false",
            "include_video": "false",
            "page": "\(page)"
        ]

        api?.sendRequest(url, parameters: parameters) { data, error in
            if let jsonData = data {
                let discoveryResponse = try? JSONDecoder().decode(DiscoveryResponse.self, from: jsonData)
                handler(discoveryResponse, error)
            } else {
                handler(nil, error)
            }
        }

    }

}

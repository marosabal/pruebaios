//
//  Request.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright © 2019 everis. All rights reserved.
//

import Foundation

protocol MovieManagerProtocol {
    func sendRequest(
        _ url: URL,
        parameters: [String: String],
        handler: @escaping (Data?, Error?) -> Void
    )
    func getMovieList(page: Int, handler: @escaping (Data?, Error?) -> Void)
    func getMovieDetails(id: Int, handler: @escaping (Data?, Error?) -> Void)
    func downloadImage(from url: URL, handler: @escaping (Data?) -> Void)
    func downloadImage(from link: String, handler: @escaping (Data?) -> Void)
}

class MovieManager: MovieManagerProtocol {

    func sendRequest(
        _ url: URL,
        parameters: [String: String],
        handler: @escaping (Data?, Error?) -> Void
        ) {

        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {

                    DispatchQueue.main.async {
                        handler(nil, error)
                    }

                    return
            }

            DispatchQueue.main.async {
                handler(data, nil)
            }
        }
        task.resume()
    }

    func getMovieDetails(id: Int, handler: @escaping (Data?, Error?) -> Void) {

        let url = URL(string: "\(ApiKeys.detail.rawValue)\(id)")!
        let parameters: [String: String] = [
            "api_key": ApiKeys.apiKey.rawValue,
            "language": ApiKeys.language.rawValue
        ]

        sendRequest(url, parameters: parameters) { data, error in
            if let jsonData = data {
                handler(jsonData, error)
            } else {
                handler(nil, error)
            }
        }
    }

    func getMovieList(page: Int, handler: @escaping (Data?, Error?) -> Void) {

        let url = URL(string: ApiKeys.url.rawValue)!
        let parameters: [String: String] = [
            "api_key": ApiKeys.apiKey.rawValue,
            "language": ApiKeys.language.rawValue,
            "sort_by": "popularity.desc",
            "include_adult": "false",
            "include_video": "false",
            "page": "\(page)"
        ]

        sendRequest(url, parameters: parameters) { data, error in
            if let jsonData = data {
                handler(jsonData, error)
            } else {
                handler(nil, error)
            }
        }

    }

    func downloadImage(from url: URL, handler: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                error == nil
                else {
                    DispatchQueue.main.async {
                        handler(nil)
                    }
                    return
            }
            DispatchQueue.main.async {
                handler(data)
            }
        }
        task.resume()
    }

    func downloadImage(from link: String, handler: @escaping (Data?) -> Void) {
        guard let url = URL(string: link) else {
            handler(nil)
            return
        }
        downloadImage(from: url, handler: handler)
    }

}

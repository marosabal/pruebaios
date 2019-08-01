//
//  Request.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright © 2019 everis. All rights reserved.
//

import Foundation

protocol ServicesProtocol {
    func sendRequest(
        _ url: URL,
        parameters: [String: String],
        handler: @escaping (Data?, Error?) -> Void
    )
}

class Services: ServicesProtocol {

    func sendRequest(
        _ url: URL,
        parameters: [String: String],
        handler: @escaping (Data?, Error?) -> Void
        ) {

        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = parameters.map { (key, value) in
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

}

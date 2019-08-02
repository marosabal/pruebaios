//
//  DetailsWorkerSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import UIKit

class DetailsWorkerSpy: DetailsWorkerProtocol {

    private(set) var isGetMovieDetailsCalled = false
    var isSuccess = true

    func getMovieDetails(id: Int, handler: @escaping (MovieDetailResponse?, Error?) -> Void) {
        isGetMovieDetailsCalled = true
        if isSuccess {
            let response = loadTestResponse()
            handler(response, nil)
        } else {
            let error = NSError(domain: "some test error", code: 500, userInfo: nil)
            handler(nil, error)
        }
    }

    func loadTestData() -> Data {
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: "MovieDetailResponse", ofType: "json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let jsonData = try! Data(contentsOf: fileUrl)
        return jsonData
    }

    func loadTestResponse() -> MovieDetailResponse {
        let jsonData = loadTestData()
        let response = try! JSONDecoder().decode(MovieDetailResponse.self, from: jsonData)
        return response
    }
}

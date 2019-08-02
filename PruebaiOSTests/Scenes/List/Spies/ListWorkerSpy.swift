//
//  ListWorkerSpy.swift
//  PruebaiOSTests
//
//  Created by Ale on 8/1/19.
//  Copyright © 2019 everis. All rights reserved.
//

@testable import PruebaiOS
import UIKit

class ListWorkerSpy: ListWorkerProtocol {

    private(set) var isGetMovieListCalled = false
    var isSuccess = true

    func getMovieList(page: Int, handler: @escaping (DiscoveryResponse?, Error?) -> Void) {
        isGetMovieListCalled = true
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
        let filePath = bundle.path(forResource: "DiscoveryResponse", ofType: "json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let jsonData = try! Data(contentsOf: fileUrl)
        return jsonData
    }

    func loadTestResponse() -> DiscoveryResponse {
        let jsonData = loadTestData()
        let response = try! JSONDecoder().decode(DiscoveryResponse.self, from: jsonData)
        return response
    }
    
}
